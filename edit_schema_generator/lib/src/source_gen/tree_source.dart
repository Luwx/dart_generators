part of 'edit_schema_source_generator.dart';

// ---------------------------------------------------------------------------
// editTree(...) — recursive structural tree schemas.
// ---------------------------------------------------------------------------

final class _TreeParseContext {
  _TreeParseContext(this.variables);

  factory _TreeParseContext.fromLibrary(ResolvedLibraryResult library) {
    final variables = <String, MethodInvocation>{};
    for (final unit in library.units) {
      for (final declaration in unit.unit.declarations) {
        if (declaration is! TopLevelVariableDeclaration) continue;
        for (final variable in declaration.variables.variables) {
          final init = variable.initializer;
          if (init is MethodInvocation) {
            variables[variable.name.lexeme] = init;
          }
        }
      }
    }
    return _TreeParseContext(variables);
  }

  final Map<String, MethodInvocation> variables;

  MethodInvocation variableInvocation(Expression expression) {
    if (expression is SimpleIdentifier) {
      final node = variables[expression.name];
      if (node != null) return node;
    }
    if (expression is MethodInvocation) return expression;
    throw _unsupported(expression, 'Expected a subtree reference.');
  }
}

final class _TreeSchemaSource {
  const _TreeSchemaSource({
    required this.id,
    required this.rootType,
    required this.rootElement,
    required this.fields,
    required this.groups,
  });

  factory _TreeSchemaSource.parse(
    MethodInvocation node,
    _TreeParseContext context,
  ) {
    final rootType = _typeArguments(node, count: 1)[0];
    final rootElement = _interfaceElementOfTypeArg(node, 0);
    return _TreeSchemaSource(
      id: _optionalStringArgument(node, 'id') ?? _lowerFirst(rootType),
      rootType: rootType,
      rootElement: rootElement,
      fields: _listArgument(node, 'fields')
          .map((expr) => _TreeFieldSource.parse(expr, rootElement, context))
          .toList(growable: false),
      groups: _optionalListArgument(
        node,
        'groups',
      ).map(_EditGroupSource.parse).toList(growable: false),
    );
  }

  final String id;
  final String rootType;
  final InterfaceElement rootElement;
  final List<_TreeFieldSource> fields;
  final List<_EditGroupSource> groups;
}

final class _TreeNodeSource {
  const _TreeNodeSource({
    required this.type,
    required this.element,
    required this.fields,
    required this.shared,
    required this.cases,
    this.groups = const [],
    this.compactSource,
    this.id,
  });

  factory _TreeNodeSource.parse(
    Expression expression,
    _TreeParseContext context,
  ) {
    final node = context.variableInvocation(expression);
    if (node.methodName.name != 'subtree') {
      throw _unsupported(node, 'Expected subtree<T>(...).');
    }
    final type = _typeArguments(node, count: 1)[0];
    final element = _interfaceElementOfTypeArg(node, 0);
    return _TreeNodeSource(
      type: type,
      element: element,
      id: _optionalStringArgument(node, 'id'),
      fields: _optionalListArgument(node, 'fields')
          .map((expr) => _TreeFieldSource.parse(expr, element, context))
          .toList(growable: false),
      shared: _optionalListArgument(node, 'shared')
          .map((expr) => _ValueFieldSource.parse(expr, element))
          .toList(growable: false),
      cases: _optionalListArgument(node, 'cases')
          .map((expr) => _TreeCaseSource.parse(expr, context))
          .toList(growable: false),
      groups: _optionalListArgument(
        node,
        'groups',
      ).map(_EditGroupSource.parse).toList(growable: false),
      compactSource: _compactWhenSource(
        _namedArgument(node, 'compactWhen')?.expression,
      ),
    );
  }

  final String type;
  final InterfaceElement element;
  final List<_TreeFieldSource> fields;
  final List<_ValueFieldSource> shared;
  final List<_TreeCaseSource> cases;
  final List<_EditGroupSource> groups;
  final String? compactSource;
  final String? id;
}

final class _TreeCaseSource {
  const _TreeCaseSource({
    required this.caseType,
    required this.caseElement,
    required this.tag,
    required this.fields,
    this.scope,
  });

  factory _TreeCaseSource.parse(
    Expression expression,
    _TreeParseContext context,
  ) {
    final node = _asInvocation(expression, 'valueCase');
    final caseType = _typeArguments(node, count: 1)[0];
    final caseElement = _interfaceElementOfTypeArg(node, 0);
    return _TreeCaseSource(
      caseType: caseType,
      caseElement: caseElement,
      tag: _stringLiteral(_firstPositionalArgument(node)),
      fields: _optionalListArgument(node, 'fields')
          .map((expr) => _TreeFieldSource.parse(expr, caseElement, context))
          .toList(growable: false),
      scope: _optionalStringArgument(node, 'scope'),
    );
  }

  final String caseType;
  final InterfaceElement caseElement;
  final String tag;
  final List<_TreeFieldSource> fields;

  /// Display-name scope for this case's fields (drops the case tag from names).
  final String? scope;
}

sealed class _TreeFieldSource {
  const _TreeFieldSource({required this.id, required this.name});

  factory _TreeFieldSource.parse(
    Expression expression,
    InterfaceElement owner,
    _TreeParseContext context,
  ) {
    final node = expression is MethodInvocation ? expression : null;
    if (node == null) throw _unsupported(expression, 'Expected tree field.');
    switch (node.methodName.name) {
      case 'prop':
        return _TreePropSource.parse(node, owner);
      case 'child':
        return _TreeChildSource.parse(node, owner, context, nullable: false);
      case 'nullable':
        return _TreeChildSource.parse(node, owner, context, nullable: true);
      case 'list':
        return _TreeListSource.parse(node, owner, context);
      case 'sealed':
        return _TreeSealedSource.parse(node, owner, context);
      case 'taggedLists':
        return _TreeTaggedListsSource.parse(node, owner, context);
      case 'dispatch':
        return _TreeDispatchSource.parse(node, owner, context);
      default:
        throw _unsupported(expression, 'Unsupported tree field.');
    }
  }

  final String id;
  final String name;
}

final class _TreePropSource extends _TreeFieldSource {
  _TreePropSource({
    required super.id,
    required super.name,
    required this.property,
    required this.type,
    required this.compare,
    required this.adapter,
    required this.readOnly,
    this.orElseSource,
    this.getSource,
    this.setSource,
  });

  factory _TreePropSource.parse(MethodInvocation node, InterfaceElement owner) {
    final id = _stringLiteral(_firstPositionalArgument(node));
    final property = _optionalStringArgument(node, 'property') ?? id;
    final access = _namedArgument(node, 'select')?.expression;
    String? getSource;
    String? setSource;
    if (access != null) {
      final lensNode = _asInvocation(access, 'lens');
      getSource = _closureArgSource(lensNode, 'get', const [r'$root']);
      setSource = _closureArgSource(lensNode, 'set', const [
        r'$root',
        r'$next',
      ]);
    }
    final readOnly = _boolArgument(node, 'readOnly', orElse: false);
    final type = readOnly
        ? 'Object?'
        : (_explicitPropFieldType(node) ??
              _lensGetReturnType(access) ??
              _fieldType(owner, property, node));
    return _TreePropSource(
      id: id,
      name: _optionalStringArgument(node, 'name') ?? id,
      property: property,
      type: type,
      compare: _compareFor(node, type),
      adapter: _AdapterSource.parse(
        _namedArgument(node, 'adapter')?.expression,
      ),
      readOnly: readOnly,
      orElseSource: _namedArgument(node, 'orElse')?.expression.toSource(),
      getSource: getSource,
      setSource: setSource,
    );
  }

  final String property;
  final String type;
  final _CompareSource compare;
  final _AdapterSource adapter;
  final bool readOnly;
  final String? orElseSource;
  final String? getSource;
  final String? setSource;

  String getter(String receiver) =>
      (getSource ?? r'$root.' + property).replaceAll(r'$root', receiver);

  String setter(String receiver, String next) =>
      (setSource ?? r'$root.copyWith(' + property + r': $next)')
          .replaceAll(r'$root', receiver)
          .replaceAll(r'$next', next);
}

final class _TreeChildSource extends _TreeFieldSource {
  _TreeChildSource({
    required super.id,
    required super.name,
    required this.property,
    required this.type,
    required this.element,
    required this.node,
    required this.nullable,
    this.scope,
    this.getSource,
    this.setSource,
  });

  /// Display-name scope token for this child's subtree (resets the name prefix).
  final String? scope;

  factory _TreeChildSource.parse(
    MethodInvocation node,
    InterfaceElement owner,
    _TreeParseContext context, {
    required bool nullable,
  }) {
    final id = _stringLiteral(_firstPositionalArgument(node));
    final property = id;
    final nodeArg = _namedArgument(node, 'node')?.expression;
    final resolvedType = _fieldType(owner, property, node);
    final childNode = nodeArg == null
        ? _TreeNodeSource(
            type: resolvedType.endsWith('?')
                ? resolvedType.substring(0, resolvedType.length - 1)
                : resolvedType,
            element: _interfaceElementFromStaticType(
              _fieldDartType(owner, property, node),
              node,
            ),
            fields: _optionalListArgument(node, 'fields')
                .map(
                  (expr) => _TreeFieldSource.parse(
                    expr,
                    _interfaceElementFromStaticType(
                      _fieldDartType(owner, property, node),
                      node,
                    ),
                    context,
                  ),
                )
                .toList(growable: false),
            shared: const [],
            cases: const [],
          )
        : _TreeNodeSource.parse(nodeArg, context);

    final access = _namedArgument(node, 'select')?.expression;
    String? getSource;
    String? setSource;
    if (access != null) {
      final lensNode = _asInvocation(access, 'lens');
      getSource = _closureArgSource(lensNode, 'get', const [r'$root']);
      setSource = _closureArgSource(lensNode, 'set', const [
        r'$root',
        r'$next',
      ]);
    }
    return _TreeChildSource(
      id: id,
      name: _optionalStringArgument(node, 'name') ?? id,
      property: property,
      type: childNode.type,
      element: childNode.element,
      node: childNode,
      nullable: nullable,
      scope: _optionalStringArgument(node, 'scope'),
      getSource: getSource,
      setSource: setSource,
    );
  }

  final String property;
  final String type;
  final InterfaceElement element;
  final _TreeNodeSource node;
  final bool nullable;
  final String? getSource;
  final String? setSource;

  String getter(String receiver) =>
      (getSource ?? r'$root.' + property).replaceAll(r'$root', receiver);

  String setter(String receiver, String next) =>
      (setSource ?? r'$root.copyWith(' + property + r': $next)')
          .replaceAll(r'$root', receiver)
          .replaceAll(r'$next', next);
}

final class _TreeListSource extends _TreeFieldSource {
  _TreeListSource({
    required super.id,
    required super.name,
    required this.property,
    required this.elementType,
    required this.element,
    required this.node,
    this.scope,
    this.location,
    this.parentField,
    this.indexField,
  });

  factory _TreeListSource.parse(
    MethodInvocation node,
    InterfaceElement owner,
    _TreeParseContext context,
  ) {
    final id = _stringLiteral(_firstPositionalArgument(node));
    final type = _fieldType(owner, id, node);
    final elementType =
        _listElementType(type) ??
        (throw _unsupported(node, 'list(...) field "$id" must be List<T>.'));
    final of = _TreeNodeSource.parse(_requiredArgument(node, 'of'), context);
    return _TreeListSource(
      id: id,
      name: _optionalStringArgument(node, 'name') ?? id,
      property: id,
      elementType: elementType,
      element: of.element,
      node: of,
      scope: _optionalStringArgument(node, 'scope'),
      location: _optionalStringArgument(node, 'location'),
      parentField: _optionalStringArgument(node, 'parentField'),
      indexField: _optionalStringArgument(node, 'indexField'),
    );
  }

  final String property;
  final String elementType;
  final InterfaceElement element;
  final _TreeNodeSource node;

  /// Display-name scope token for this list's subtree (resets the name prefix).
  final String? scope;

  /// When set, collapse this list's mixed params (an inherited location +
  /// trailing index) into one generated location class named [location].
  final String? location;

  /// Field name for the inherited location param inside the synthesized
  /// [location] class (e.g. `gesture`).
  final String? parentField;

  /// Field name for this list's index inside the synthesized [location]
  /// class (e.g. `actionIndex`); defaults to `{singular}Index`.
  final String? indexField;
}

final class _TreeSealedSource extends _TreeFieldSource {
  _TreeSealedSource({
    required super.id,
    required super.name,
    required this.property,
    required this.type,
    required this.element,
    required this.shared,
    required this.cases,
  });

  factory _TreeSealedSource.parse(
    MethodInvocation node,
    InterfaceElement owner,
    _TreeParseContext context,
  ) {
    final id = _stringLiteral(_firstPositionalArgument(node));
    final type = _fieldType(owner, id, node);
    final element = _interfaceElementFromStaticType(
      _fieldDartType(owner, id, node),
      node,
    );
    return _TreeSealedSource(
      id: id,
      name: _optionalStringArgument(node, 'name') ?? id,
      property: id,
      type: type,
      element: element,
      shared: _optionalListArgument(node, 'shared')
          .map((expr) => _ValueFieldSource.parse(expr, element))
          .toList(growable: false),
      cases: _listArgument(node, 'cases')
          .map((expr) => _TreeCaseSource.parse(expr, context))
          .toList(growable: false),
    );
  }

  final String property;
  final String type;
  final InterfaceElement element;
  final List<_ValueFieldSource> shared;
  final List<_TreeCaseSource> cases;
}

final class _TreeTaggedListsSource extends _TreeFieldSource {
  _TreeTaggedListsSource({
    required this.locationType,
    required this.elementType,
    required this.categoryType,
    required this.lensName,
    required this.discriminator,
    required this.indexField,
    required this.baseName,
    required this.shared,
    required this.sharedOwner,
    required this.entries,
    required this.generateLocation,
    this.key,
  }) : super(id: baseName, name: baseName);

  factory _TreeTaggedListsSource.parse(
    MethodInvocation node,
    InterfaceElement owner,
    _TreeParseContext context,
  ) {
    final typeArgs = _typeArguments(node, count: 3);
    final locationType = typeArgs[0];
    final elementType = typeArgs[1];
    final categoryType = typeArgs[2];
    final elementElement = _interfaceElementOfTypeArg(node, 1);
    final lensName = _stringArgument(node, 'lens');
    final baseName =
        _optionalStringArgument(node, 'name') ?? _lowerFirst(elementType);

    final keyArg = _namedArgument(node, 'key')?.expression;
    _TaggedListKeySource? key;
    if (keyArg != null) {
      if (_optionalStringArgument(node, 'index') != null) {
        throw _unsupported(
          node,
          'taggedLists key: and index: are mutually exclusive.',
        );
      }
      final keyNode = _asInvocation(keyArg, 'listKey');
      key = _TaggedListKeySource(
        field: _stringArgument(keyNode, 'field'),
        type: _typeArguments(keyNode, count: 2)[1],
        getSource: _closureArgSource(keyNode, 'get', const [r'$element']),
      );
    }

    final map = _requiredArgument(node, 'lists');
    if (map is! SetOrMapLiteral || !map.isMap) {
      throw _unsupported(map, 'taggedLists lists: must be a map literal.');
    }
    final entries = <_TaggedListEntry>[];
    for (final element in map.elements) {
      if (element is! MapLiteralEntry) continue;
      final value = element.value;
      if (value is! RecordLiteral || value.fields.length != 2) {
        throw _unsupported(value, 'taggedLists entries must be records.');
      }
      final property = _stringLiteral(value.fields[0]);
      final nodeSource = _TreeNodeSource.parse(value.fields[1], context);
      entries.add(
        _TaggedListEntry(
          enumSource: element.key.toSource(),
          property: property,
          elementType: nodeSource.type,
          node: nodeSource,
        ),
      );
    }

    return _TreeTaggedListsSource(
      locationType: locationType,
      elementType: elementType,
      categoryType: categoryType,
      lensName: lensName,
      discriminator: _stringArgument(node, 'discriminator'),
      indexField: _optionalStringArgument(node, 'index') ?? 'index',
      baseName: baseName,
      shared: _optionalListArgument(node, 'shared')
          .map((expr) => _TreeFieldSource.parse(expr, elementElement, context))
          .toList(growable: false),
      sharedOwner: elementElement,
      entries: entries,
      generateLocation: _boolArgument(node, 'generateLocation', orElse: false),
      key: key,
    );
  }

  /// The single coordinate type (e.g. `GestureLocation`).
  final String locationType;

  /// The lists' common supertype the dispatcher returns (e.g. `Gesture`).
  final String elementType;

  /// The discriminator enum type (e.g. `DeviceType`).
  final String categoryType;
  final String lensName;
  final String discriminator;
  final String indexField;

  /// Emit the [locationType] value class instead of treating it as external.
  final bool generateLocation;
  final String baseName;
  final List<_TreeFieldSource> shared;
  final InterfaceElement sharedOwner;
  final List<_TaggedListEntry> entries;

  /// When set, the coordinate is identity-keyed: the location carries the
  /// element key named [_TaggedListKeySource.field] instead of [indexField],
  /// and lenses resolve elements by key lookup at read time.
  final _TaggedListKeySource? key;
}

final class _TaggedListKeySource {
  const _TaggedListKeySource({
    required this.field,
    required this.type,
    required this.getSource,
  });

  /// The location field carrying the key (e.g. `editId`).
  final String field;

  /// The key's (non-nullable) source type (e.g. `int`).
  final String type;

  /// Key extraction source with the element rewritten to `$element`
  /// (e.g. `$element.common.editId`).
  final String getSource;

  String getter(String receiver) => getSource.replaceAll(r'$element', receiver);
}

final class _TaggedListEntry {
  const _TaggedListEntry({
    required this.enumSource,
    required this.property,
    required this.elementType,
    required this.node,
  });

  final String enumSource;
  final String property;
  final String elementType;
  final _TreeNodeSource node;

  String get baseName => _singular(_lowerFirst(elementType));
}

final class _TreeDispatchSource extends _TreeFieldSource {
  _TreeDispatchSource({
    required this.categoryType,
    required this.lensName,
    required this.baseName,
    required this.paramName,
    required this.elementType,
    required this.element,
    required this.node,
    required this.branches,
  }) : super(id: baseName, name: baseName);

  factory _TreeDispatchSource.parse(
    MethodInvocation node,
    InterfaceElement owner,
    _TreeParseContext context,
  ) {
    final categoryType = _typeArguments(node, count: 1)[0];
    final lensName = _stringArgument(node, 'lens');
    final nodeSource = _TreeNodeSource.parse(
      _requiredArgument(node, 'node'),
      context,
    );
    final baseName =
        _optionalStringArgument(node, 'name') ?? _lowerFirst(nodeSource.type);
    final paramName = _optionalStringArgument(node, 'param') ?? 'category';

    final map = _requiredArgument(node, 'branches');
    if (map is! SetOrMapLiteral || !map.isMap) {
      throw _unsupported(map, 'dispatch branches: must be a map literal.');
    }
    final branches = <_DispatchBranch>[];
    for (final element in map.elements) {
      if (element is! MapLiteralEntry) continue;
      branches.add(
        _DispatchBranch(
          enumSource: element.key.toSource(),
          property: _stringLiteral(element.value),
        ),
      );
    }

    return _TreeDispatchSource(
      categoryType: categoryType,
      lensName: lensName,
      baseName: baseName,
      paramName: paramName,
      elementType: nodeSource.type,
      element: nodeSource.element,
      node: nodeSource,
      branches: branches,
    );
  }

  /// The discriminator enum type (e.g. `DeviceType`).
  final String categoryType;

  /// Name of the generated section dispatcher (e.g. `speedSettingsLens`).
  final String lensName;

  /// Base name for the per-field lens family (e.g. `speed` -> `speedEventsLens`).
  final String baseName;

  /// Cosmetic parameter name in the generated lenses (e.g. `category`).
  final String paramName;

  /// The shared node type stored under every branch (e.g. `SpeedSettings`).
  final String elementType;
  final InterfaceElement element;
  final _TreeNodeSource node;
  final List<_DispatchBranch> branches;
}

final class _DispatchBranch {
  const _DispatchBranch({required this.enumSource, required this.property});

  /// The category enum value, e.g. `DeviceType.mouse`.
  final String enumSource;

  /// The nullable property on the root holding this branch (e.g. `mouseSpeed`).
  final String property;
}

final class _TreePath {
  const _TreePath({
    required this.rootType,
    required this.rootExpr,
    required this.params,
    required this.nameParts,
    required this.parts,
    required this.valueExpr,
    List<String>? displayParts,
    this.scoped = false,
    this.locationName,
  }) : displayParts = displayParts ?? nameParts;

  final String rootType;
  final String rootExpr;
  final List<_TreeParam> params;

  /// The full traversal path, one segment per hop. Drives the private
  /// `LensPart` variable names, so it must stay unique per distinct hop.
  final List<String> nameParts;

  /// The *display* path used for public lens/field names. Diverges from
  /// [nameParts] under a [scoped] subtree: a [scope] resets it to the scope
  /// token and structural hops (sealed wrappers, case casts) are dropped.
  final List<String> displayParts;
  final List<String> parts;
  final String valueExpr;

  /// True once a [scope] has been entered; enables dropping structural hops
  /// from [displayParts] (safe because props are unique within a scope).
  final bool scoped;

  /// When set, the lens takes one location object of this type (synthesized
  /// from mixed-type [params] — e.g. an inherited location + a trailing index)
  /// rather than positional params.
  final String? locationName;

  _TreePath append({
    required String part,
    required String valueExpr,
    required String name,
    List<_TreeParam>? params,
    String? scope,
    bool structural = false,
    String? rootExpr,
    String? locationName,
  }) {
    final List<String> nextDisplay;
    if (scope != null) {
      nextDisplay = [scope];
    } else if (structural && scoped) {
      nextDisplay = displayParts;
    } else {
      nextDisplay = [...displayParts, name];
    }
    return _TreePath(
      rootType: rootType,
      rootExpr: rootExpr ?? this.rootExpr,
      params: params ?? this.params,
      nameParts: [...nameParts, name],
      displayParts: nextDisplay,
      parts: [...parts, part],
      valueExpr: valueExpr,
      scoped: scoped || scope != null,
      locationName: locationName ?? this.locationName,
    );
  }

  /// The compacted public name for a leaf at this path, e.g.
  /// `displayParts ['action', 'command']` -> `actionCommand`.
  String get lensName =>
      _lowerFirst(_compactNameParts(displayParts).map(_pascal).join());

  String get lensBase =>
      parts.fold(rootExpr, (value, part) => '$value.then($part)');

  /// True when the lens takes a single location object instead of positional
  /// indices: either an explicitly named location ([locationName], synthesized
  /// from mixed params) or an all-`int` path whose indices fold into a
  /// generated `{...}Location`.
  bool get usesLocation =>
      params.isNotEmpty &&
      (locationName != null || params.every((param) => param.type == 'int'));

  /// Name of the location class for this path: the explicit [locationName], or
  /// one derived from int index params (`[carIndex, permitIndex]` ->
  /// `CarPermitLocation`).
  String get locationType =>
      locationName ??
      '${params.map((param) => _pascal(_stripIndexSuffix(param.name))).join()}Location';

  String get lensParams {
    if (params.isEmpty) return '';
    if (usesLocation) return '$locationType location';
    return params.map((param) => '${param.type} ${param.name}').join(', ');
  }
}

final class _TreeParam {
  const _TreeParam({required this.type, required this.name, String? accessor})
    : accessor = accessor ?? name;

  final String type;
  final String name;

  /// How to reference this param inside a lens body — its bare [name] for
  /// positional lenses, or `location.<name>` when the path uses a generated
  /// location object.
  final String accessor;
}

/// Strips a trailing `Index` from an index-param name (`carIndex` -> `car`).
String _stripIndexSuffix(String name) => name.endsWith('Index')
    ? name.substring(0, name.length - 'Index'.length)
    : name;

/// Removes adjacent duplicate segments from a display-name path
/// (`[action, action, command, command]` -> `[action, command]`). A safety net
/// for any duplicates that survive scope/structural handling.
List<String> _compactNameParts(List<String> parts) {
  final result = <String>[];
  for (final part in parts) {
    if (part.isEmpty) continue;
    if (result.isNotEmpty && result.last.toLowerCase() == part.toLowerCase()) {
      continue;
    }
    result.add(part);
  }
  return result;
}

final class _TreeLens {
  const _TreeLens({
    required this.name,
    required this.type,
    required this.path,
    required this.prop,
    required this.receiver,
  });

  final String name;
  final String type;
  final _TreePath path;
  final _TreePropSource prop;
  final String receiver;
}
