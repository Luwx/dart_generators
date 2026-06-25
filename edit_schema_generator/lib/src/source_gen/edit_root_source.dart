part of 'edit_schema_source_generator.dart';

final class _EditRootSource {
  const _EditRootSource({
    required this.id,
    required this.rootType,
    required this.lensRootType,
    required this.locationType,
    required this.rootLens,
    required this.savedBacking,
    required this.fields,
    required this.groups,
  });

  factory _EditRootSource.parse(MethodInvocation node) {
    final typeArguments = _typeArguments(node, count: 2);
    final fields = _listArgument(
      node,
      'fields',
    ).map(_EditFieldSource.parse).toList(growable: false);
    final groups = _optionalListArgument(
      node,
      'groups',
    ).map(_EditGroupSource.parse).toList(growable: false);

    return _EditRootSource(
      id: _stringArgument(node, 'id'),
      rootType: _optionalStringArgument(node, 'rootType') ?? typeArguments[0],
      lensRootType:
          _optionalStringArgument(node, 'lensRootType') ?? typeArguments[0],
      locationType:
          _optionalStringArgument(node, 'locationType') ?? typeArguments[1],
      rootLens: _stringArgument(node, 'rootLens'),
      savedBacking: _SavedBackingSource.parse(
        _requiredArgument(node, 'savedBacking'),
      ),
      fields: fields,
      groups: groups,
    );
  }

  /// Parses the tree `editSchema(...)` surface from a resolved node.
  factory _EditRootSource.parseSchema(MethodInvocation node) {
    final typeArguments = _typeArguments(node, count: 2);
    final rootType = typeArguments[0];
    final locationType = typeArguments[1];
    final id = _optionalStringArgument(node, 'id') ?? _lowerFirst(rootType);
    final rootLens = _optionalStringArgument(node, 'rootLens') ?? '${id}Lens';

    final rootElement = _interfaceElementOfTypeArg(node, 0);

    final fields = <_EditFieldSource>[];
    for (final fieldExpr in _listArgument(node, 'fields')) {
      if (fieldExpr is! MethodInvocation) {
        throw _unsupported(fieldExpr, 'Expected prop(...) or union<...>(...).');
      }
      switch (fieldExpr.methodName.name) {
        case 'prop':
          fields.add(_parseLeafProp(fieldExpr, rootElement));
        case 'union':
          _parseUnionFields(fieldExpr, fields);
        default:
          throw _unsupported(
            fieldExpr,
            'Expected prop(...) or union<...>(...).',
          );
      }
    }

    final groups = _optionalListArgument(node, 'groups')
        .map((groupExpr) {
          final groupNode = _asInvocation(groupExpr, 'editGroup');
          return _EditGroupSource(
            id: _stringArgument(groupNode, 'id'),
            members: _listArgument(
              groupNode,
              'members',
            ).map(_stringLiteral).toList(growable: false),
          );
        })
        .toList(growable: false);

    return _EditRootSource(
      id: id,
      rootType: rootType,
      lensRootType: _inferRootLensRootType(node, rootLens) ?? rootType,
      locationType: locationType,
      rootLens: rootLens,
      savedBacking: const _SavedBackingSource(source: 'saved != null'),
      fields: fields,
      groups: groups,
    );
  }

  final String id;
  final String rootType;
  final String lensRootType;
  final String locationType;
  final String rootLens;
  final _SavedBackingSource savedBacking;
  final List<_EditFieldSource> fields;
  final List<_EditGroupSource> groups;
}

String? _inferRootLensRootType(MethodInvocation node, String rootLens) {
  final unit = node.thisOrAncestorOfType<CompilationUnit>();
  if (unit == null) return null;
  for (final declaration in unit.declarations) {
    if (declaration is! FunctionDeclaration) continue;
    if (declaration.name.lexeme != rootLens) continue;
    return _firstLensTypeArgument(declaration.returnType?.toSource());
  }
  return null;
}

String? _firstLensTypeArgument(String? returnType) {
  if (returnType == null) return null;
  const prefix = 'Lens<';
  final source = returnType.trim();
  if (!source.startsWith(prefix) || !source.endsWith('>')) return null;
  var depth = 0;
  final body = source.substring(prefix.length, source.length - 1);
  for (var i = 0; i < body.length; i++) {
    final char = body[i];
    if (char == '<') {
      depth++;
    } else if (char == '>') {
      depth--;
    } else if (char == ',' && depth == 0) {
      return body.substring(0, i).trim();
    }
  }
  return null;
}

final class _EditFieldSource {
  const _EditFieldSource({
    required this.id,
    required this.type,
    required this.selector,
    required this.compare,
    required this.restore,
    required this.fallback,
    required this.adapter,
    this.backing,
    this.isReadOnly = false,
  });

  factory _EditFieldSource.parse(Expression expression) {
    final node = _asInvocation(expression, 'field');
    final typeArguments = _typeArguments(node, count: 2);
    final id = _stringArgument(node, 'id');
    final selector = _SelectorSource.parse(
      _requiredArgument(node, 'select'),
      fieldId: id,
    );

    return _EditFieldSource(
      id: id,
      type: _optionalStringArgument(node, 'type') ?? typeArguments[1],
      selector: selector,
      compare: _namedArgument(node, 'compare') == null
          ? _CompareSource.defaultFor(typeArguments[1])
          : _CompareSource.parse(_requiredArgument(node, 'compare')),
      restore: _namedArgument(node, 'restore') == null
          ? _RestoreSource.defaultFor(selector)
          : _RestoreSource.parse(_requiredArgument(node, 'restore')),
      fallback: _FallbackSource.parse(
        _namedArgument(node, 'fallback')?.expression,
      ),
      adapter: _AdapterSource.parse(
        _namedArgument(node, 'adapter')?.expression,
      ),
      backing: _BackingSource.parse(
        _namedArgument(node, 'backing')?.expression,
      ),
    );
  }

  final String id;
  final String type;
  final _SelectorSource selector;
  final _CompareSource compare;
  final _RestoreSource restore;
  final _FallbackSource fallback;
  final _AdapterSource adapter;

  /// Per-field saved-backing override, or null when the field inherits the
  /// root's saved-backing predicate.
  final _BackingSource? backing;

  /// A comparison-only field: it contributes an enum member, a comparable
  /// projection, and a saved-backing branch, but no lens accessor, no
  /// [GeneratedEditField] ref, and a no-op restore.
  final bool isReadOnly;
}

sealed class _SelectorSource {
  const _SelectorSource();

  factory _SelectorSource.parse(
    Expression expression, {
    required String fieldId,
  }) {
    final node = expression is MethodInvocation ? expression : null;
    if (node == null) {
      throw _unsupported(expression, 'Expected leaf(...) or unionField(...).');
    }
    return switch (node.methodName.name) {
      'leaf' => _LeafSource.parse(node, fieldId: fieldId),
      'unionField' => _UnionSource.parse(node, fieldId: fieldId),
      _ => throw _unsupported(node, 'Expected leaf(...) or unionField(...).'),
    };
  }
}

final class _LeafSource extends _SelectorSource {
  const _LeafSource({required this.fieldName, this.getSource, this.setSource});

  factory _LeafSource.parse(MethodInvocation node, {required String fieldId}) {
    return _LeafSource(
      fieldName: _optionalStringArgument(node, 'fieldName') ?? fieldId,
    );
  }

  final String fieldName;

  /// Override get/set, in `$root`/`$next` placeholder form; null uses defaults.
  final String? getSource;
  final String? setSource;

  String getterExpression(String root) =>
      (getSource ?? r'$root.' + fieldName).replaceAll(r'$root', root);

  String setterExpression(String root, String next) =>
      (setSource ?? r'$root.copyWith(' + fieldName + r': $next)')
          .replaceAll(r'$root', root)
          .replaceAll(r'$next', next);
}

final class _UnionSource extends _SelectorSource {
  const _UnionSource({
    required this.fieldName,
    required this.caseType,
    required this.caseField,
    this.getSource,
    this.setSource,
    this.caseSource,
    this.setCaseSource,
  });

  factory _UnionSource.parse(MethodInvocation node, {required String fieldId}) {
    final typeArguments = _typeArguments(node, count: 3);
    final caseField =
        _optionalStringArgument(node, 'caseField') ??
        _inferCaseField(_requiredArgument(node, 'getCase'));
    return _UnionSource(
      fieldName: _optionalStringArgument(node, 'fieldName') ?? fieldId,
      caseType: _optionalStringArgument(node, 'caseType') ?? typeArguments[1],
      caseField: caseField,
    );
  }

  final String fieldName;
  final String caseType;
  final String caseField;

  /// Override the inner case-field get/set (`$case`/`$next` placeholders).
  final String? getSource;
  final String? setSource;

  /// Override the case get/replace (`$root`/`$case` placeholders).
  final String? caseSource;
  final String? setCaseSource;

  String caseExpression(String root) =>
      (caseSource ?? r'$root.' + caseField).replaceAll(r'$root', root);

  String replaceCaseExpression(String root, String nextCase) =>
      (setCaseSource ?? r'$root.copyWith(' + caseField + r': $case)')
          .replaceAll(r'$root', root)
          .replaceAll(r'$case', nextCase);

  String getterExpression(String caseVar) =>
      (getSource ?? r'$case.' + fieldName).replaceAll(r'$case', caseVar);

  String setterExpression(String caseVar, String next) =>
      (setSource ?? r'$case.copyWith(' + fieldName + r': $next)')
          .replaceAll(r'$case', caseVar)
          .replaceAll(r'$next', next);
}

final class _CompareSource {
  const _CompareSource({required this.kind, this.projectSource});

  factory _CompareSource.defaultFor(String type) {
    if (type.startsWith('List<') ||
        type.startsWith('Set<') ||
        type.startsWith('Map<')) {
      return const _CompareSource(kind: _CompareKind.deepCollection);
    }
    return const _CompareSource(kind: _CompareKind.scalar);
  }

  factory _CompareSource.parse(Expression expression) {
    final name = _callName(expression);
    return switch (name) {
      'scalar' => const _CompareSource(kind: _CompareKind.scalar),
      'deepCollection' ||
      'deep' => const _CompareSource(kind: _CompareKind.deepCollection),
      'projected' => _CompareSource(
        kind: _CompareKind.projected,
        projectSource: _projectedSource(expression),
      ),
      'composed' => const _CompareSource(kind: _CompareKind.composed),
      _ => throw _unsupported(expression, 'Unsupported compare expression.'),
    };
  }

  final _CompareKind kind;
  final String? projectSource;
}

enum _CompareKind { scalar, deepCollection, projected, composed }

final class _RestoreSource {
  const _RestoreSource({required this.kind});

  factory _RestoreSource.defaultFor(_SelectorSource selector) {
    return switch (selector) {
      _UnionSource() => const _RestoreSource(kind: _RestoreKind.mergeLeaf),
      _LeafSource() => const _RestoreSource(kind: _RestoreKind.replaceLeaf),
    };
  }

  factory _RestoreSource.parse(Expression expression) {
    final name = _callName(expression);
    return switch (name) {
      'replaceLeaf' => const _RestoreSource(kind: _RestoreKind.replaceLeaf),
      'mergeLeaf' => const _RestoreSource(kind: _RestoreKind.mergeLeaf),
      _ => throw _unsupported(expression, 'Unsupported restore expression.'),
    };
  }

  final _RestoreKind kind;
}

enum _RestoreKind { replaceLeaf, mergeLeaf }

final class _FallbackSource {
  const _FallbackSource({required this.kind, this.source});

  factory _FallbackSource.parse(Expression? expression) {
    if (expression == null) {
      return const _FallbackSource(kind: _FallbackKind.fromSelect);
    }
    final name = _callName(expression);
    return switch (name) {
      'noFallback' => const _FallbackSource(kind: _FallbackKind.none),
      'fallback' => _FallbackSource(
        kind: _FallbackKind.custom,
        source: _fallbackSource(expression),
      ),
      _ => throw _unsupported(expression, 'Unsupported fallback expression.'),
    };
  }

  final _FallbackKind kind;
  final String? source;
}

enum _FallbackKind { fromSelect, none, custom }

final class _AdapterSource {
  const _AdapterSource._({this.kind, this.source});

  factory _AdapterSource.parse(Expression? expression) {
    if (expression == null) {
      return const _AdapterSource._(kind: _AdapterKind.identity);
    }
    final name = _callName(expression);
    return switch (name) {
      'nullableText' => const _AdapterSource._(kind: _AdapterKind.nullableText),
      'nullableInt' => const _AdapterSource._(kind: _AdapterKind.nullableInt),
      'nullableDouble' => const _AdapterSource._(
        kind: _AdapterKind.nullableDouble,
      ),
      // Any other expression is a custom adapter (e.g. FieldAdapterSpec.custom
      // or a user-defined helper); emit it verbatim. The generated code is a
      // part of the schema library, so private helpers it references resolve.
      _ => _AdapterSource._(source: expression.toSource()),
    };
  }

  /// One of the built-in adapter kinds, or `null` for a verbatim [source].
  final _AdapterKind? kind;

  /// Raw source of a custom adapter expression, used when [kind] is `null`.
  final String? source;

  String expression(String type) => switch (kind) {
    _AdapterKind.identity => 'FieldAdapterSpec<$type>.identity()',
    _AdapterKind.nullableText => 'FieldAdapterSpec<$type>.nullableText()',
    _AdapterKind.nullableInt => 'FieldAdapterSpec<$type>.nullableInt()',
    _AdapterKind.nullableDouble => 'FieldAdapterSpec<$type>.nullableDouble()',
    null => source!,
  };
}

enum _AdapterKind { identity, nullableText, nullableInt, nullableDouble }

final class _SavedBackingSource {
  const _SavedBackingSource({required this.source});

  factory _SavedBackingSource.parse(Expression expression) {
    if (_callName(expression) == 'rootExists') {
      return const _SavedBackingSource(source: 'saved != null');
    }
    throw _unsupported(expression, 'Unsupported savedBacking expression.');
  }

  final String source;
}

/// Per-field saved-backing override parsed from a `backing:` argument. [source]
/// is an expression in terms of a nullable `saved` root variable.
final class _BackingSource {
  const _BackingSource({required this.source});

  static _BackingSource? parse(Expression? expression) {
    if (expression == null) return null;
    final name = _callName(expression);
    return switch (name) {
      'rootExists' => const _BackingSource(source: 'saved != null'),
      'backedWhen' => _BackingSource(
        source: 'saved != null && (${_backingPredicateSource(expression)})',
      ),
      _ => throw _unsupported(expression, 'Unsupported backing expression.'),
    };
  }

  final String source;
}

final class _EditGroupSource {
  const _EditGroupSource({required this.id, required this.members});

  factory _EditGroupSource.parse(Expression expression) {
    final node = _asInvocation(expression, 'editGroup');
    return _EditGroupSource(
      id: _stringArgument(node, 'id'),
      members: _listArgument(
        node,
        'members',
      ).map(_stringLiteral).toList(growable: false),
    );
  }

  final String id;
  final List<String> members;
}

/// Parses a `prop('id', ...)` leaf node against its owning class element.
_EditFieldSource _parseLeafProp(
  MethodInvocation node,
  InterfaceElement rootElement,
) {
  final id = _stringLiteral(_firstPositionalArgument(node));

  if (_namedArgument(node, 'defaultsTo') != null) {
    throw _unsupported(
      node,
      'prop "$id": defaultsTo is only supported in tree schemas (editTree); use '
      'select: + compare: projected(...) in a flat editSchema.',
    );
  }

  // Comparison-only fields have no underlying property/lens, so they skip class
  // type resolution and must carry an explicit projected compare.
  if (_boolArgument(node, 'readOnly', orElse: false)) {
    final compareArg = _namedArgument(node, 'compare')?.expression;
    if (compareArg == null || _callName(compareArg) != 'projected') {
      throw _unsupported(
        node,
        'read-only props require compare: projected(...).',
      );
    }
    return _EditFieldSource(
      id: id,
      type: 'Object?',
      selector: _LeafSource(fieldName: id),
      compare: _CompareSource.parse(compareArg),
      restore: const _RestoreSource(kind: _RestoreKind.replaceLeaf),
      fallback: const _FallbackSource(kind: _FallbackKind.none),
      adapter: const _AdapterSource._(kind: _AdapterKind.identity),
      backing: _BackingSource.parse(
        _namedArgument(node, 'backing')?.expression,
      ),
      isReadOnly: true,
    );
  }

  final property = _optionalStringArgument(node, 'property') ?? id;

  final access = _namedArgument(node, 'select')?.expression;
  String? getSource;
  String? setSource;
  if (access != null) {
    final lensNode = _asInvocation(access, 'lens');
    getSource = _closureArgSource(lensNode, 'get', const [r'$root']);
    setSource = _closureArgSource(lensNode, 'set', const [r'$root', r'$next']);
  }

  // A dispatched field reached through a `select:` lens (e.g. a property living
  // on sealed subtypes but not the base) has no member on the root class, so
  // resolve its type from the lens `get` return type before the class lookup.
  final type =
      _explicitPropFieldType(node) ??
      _lensGetReturnType(access) ??
      _fieldType(rootElement, property, node);

  return _EditFieldSource(
    id: id,
    type: type,
    selector: _LeafSource(
      fieldName: property,
      getSource: getSource,
      setSource: setSource,
    ),
    compare: _compareFor(node, type),
    restore: _restoreFor(node, _RestoreKind.replaceLeaf),
    fallback: _FallbackSource.parse(
      _namedArgument(node, 'fallback')?.expression,
    ),
    adapter: _AdapterSource.parse(_namedArgument(node, 'adapter')?.expression),
    backing: _BackingSource.parse(_namedArgument(node, 'backing')?.expression),
  );
}

/// Parses a `union<Case>('via', fields: [...])` node, appending one field per
/// nested `prop(...)` child to [out].
void _parseUnionFields(MethodInvocation node, List<_EditFieldSource> out) {
  final caseType = _typeArguments(node, count: 1)[0];
  final caseElement = _maybeInterfaceElementOfTypeArg(node, 0);
  final caseField = _stringLiteral(_firstPositionalArgument(node));

  final caseAccess = _namedArgument(node, 'select')?.expression;
  String? caseSource;
  String? setCaseSource;
  if (caseAccess != null) {
    final caseLens = _asInvocation(caseAccess, 'caseLens');
    caseSource = _closureArgSource(caseLens, 'get', const [r'$root']);
    setCaseSource = _closureArgSource(caseLens, 'set', const [
      r'$root',
      r'$case',
    ]);
  } else if (caseField == 'self') {
    // Self-union: the root value *is* the case. Read it directly (the emitter
    // appends `as Case`) and replace the whole root with the next case.
    caseSource = r'$root';
    setCaseSource = r'$case';
  }

  for (final childExpr in _listArgument(node, 'fields')) {
    final child = _asInvocation(childExpr, 'prop');
    final id = _stringLiteral(_firstPositionalArgument(child));
    final property = _optionalStringArgument(child, 'property') ?? id;

    final access = _namedArgument(child, 'select')?.expression;
    String? getSource;
    String? setSource;
    if (access != null) {
      final lensNode = _asInvocation(access, 'lens');
      getSource = _closureArgSource(lensNode, 'get', const [r'$case']);
      setSource = _closureArgSource(lensNode, 'set', const [
        r'$case',
        r'$next',
      ]);
    }

    // Prefer an explicit type, then a `select:` lens `get` return type, then
    // the case class member. The lens fallback also covers cases whose type
    // does not resolve to an interface.
    final type =
        _explicitPropFieldType(child) ??
        _lensGetReturnType(access) ??
        (caseElement == null
            ? throw _unsupported(
                child,
                'Union child prop needs explicit field type when the case '
                'type does not resolve.',
              )
            : _fieldType(caseElement, property, child));

    out.add(
      _EditFieldSource(
        id: id,
        type: type,
        selector: _UnionSource(
          fieldName: property,
          caseType: caseType,
          caseField: caseField,
          getSource: getSource,
          setSource: setSource,
          caseSource: caseSource,
          setCaseSource: setCaseSource,
        ),
        compare: _compareFor(child, type),
        restore: _restoreFor(child, _RestoreKind.mergeLeaf),
        fallback: _FallbackSource.parse(
          _namedArgument(child, 'fallback')?.expression,
        ),
        adapter: _AdapterSource.parse(
          _namedArgument(child, 'adapter')?.expression,
        ),
        backing: _BackingSource.parse(
          _namedArgument(child, 'backing')?.expression,
        ),
      ),
    );
  }
}
