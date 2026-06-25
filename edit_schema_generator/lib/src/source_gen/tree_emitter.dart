part of 'edit_schema_source_generator.dart';

final class _TreeSchemaEmitter {
  const _TreeSchemaEmitter();

  String emit(_TreeSchemaSource schema) {
    final parts = StringBuffer();
    final body = StringBuffer()
      ..writeln('// Generated code. Do not modify by hand.')
      ..writeln(
        '// ignore_for_file: dead_code, prefer_null_aware_operators, '
        'lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, '
        'unnecessary_parenthesis, unreachable_switch_case, unused_element, '
        'invalid_null_aware_operator, unused_local_variable, '
        'avoid_equals_and_hash_code_on_mutable_classes, '
        'no_literal_bool_comparisons',
      )
      ..writeln();

    final rootName = _pascal(schema.id);
    final fieldEnum = '${rootName}DirtyField';
    final lenses = <_TreeLens>[];
    final structuralLenses = <_TreeStructuralLens>[];
    final comparableNodes = <String, _TreeNodeSource>{};
    final rootPath = _TreePath(
      rootType: schema.rootType,
      rootExpr: '_${schema.id}RootLens()',
      params: const [],
      nameParts: const [],
      parts: const [],
      valueExpr: 'value',
    );

    body
      ..writeln(
        'Lens<${schema.rootType}, ${schema.rootType}> _${schema.id}RootLens() => Lens<${schema.rootType}, ${schema.rootType}>(',
      )
      ..writeln('  get: (root) => root as ${schema.rootType},')
      ..writeln('  set: (root, next) => next,')
      ..writeln("  name: '${schema.id}',")
      ..writeln(');')
      ..writeln();

    _collectFields(
      parts,
      lenses,
      structuralLenses,
      comparableNodes,
      schema.fields,
      schema.rootType,
      schema.rootElement,
      rootPath,
      rootId: schema.id,
    );

    body
      ..writeln('enum $fieldEnum {')
      ..writeAll(lenses.map((lens) => '  ${lens.name},\n'))
      ..writeln('}')
      ..writeln();

    _writeLocationClasses(body, lenses);
    _writeTaggedLocationClasses(body, schema.fields);

    body.write(parts.toString());

    _writeStructuralLenses(body, structuralLenses);

    for (final lens in lenses) {
      body
        ..writeln(
          'Lens<${schema.rootType}, ${lens.type}> ${lens.name}Lens(${lens.path.lensParams}) =>',
        )
        ..writeln('    ${lens.path.lensBase};');
      if (lens.path.lensParams.isEmpty) body.writeln();
      body.writeln();
    }

    _writeFieldExtras(body, schema, fieldEnum, lenses);

    body
      ..writeln('Object? comparable${rootName}FieldValue(')
      ..writeln('  ${schema.rootType}? value,')
      ..writeln('  $fieldEnum field,')
      ..writeln(') => switch (field) {');
    for (final lens in lenses) {
      final projection = lens.path.params.isEmpty
          ? _fieldProjection(lens.prop, lens.receiver, nullSafe: true)
          : 'null';
      body.writeln('  $fieldEnum.${lens.name} => $projection,');
    }
    body
      ..writeln('};')
      ..writeln();

    final rootNode = _TreeNodeSource(
      type: schema.rootType,
      element: schema.rootElement,
      fields: schema.fields,
      shared: const [],
      cases: const [],
      groups: schema.groups,
    );
    comparableNodes[schema.rootType] = rootNode;
    for (final entry in comparableNodes.entries) {
      _writeComparableNode(body, entry.value);
      _writeNodeGroups(body, entry.value);
    }

    return body.toString();
  }

  /// Emits one immutable `{...}Location` class per distinct index-param path
  /// (e.g. `CarLocation { int carIndex }`, `CarPermitLocation { int carIndex,
  /// permitIndex }`). These replace positional indices in the lens signatures
  /// and double as stable provider/map keys, so they carry value equality.
  void _writeLocationClasses(StringBuffer buffer, List<_TreeLens> lenses) {
    final seen = <String, List<_TreeParam>>{};
    for (final lens in lenses) {
      if (!lens.path.usesLocation) continue;
      seen.putIfAbsent(lens.path.locationType, () => lens.path.params);
    }
    if (seen.isEmpty) return;
    final names = seen.keys.toList()..sort();
    for (final name in names) {
      _writeLocationClass(buffer, name, seen[name]!);
    }
  }

  /// Emits the [TLocation] value classes for `taggedLists(generateLocation:
  /// true)` — the discriminator coordinate, owned by the generated tree.
  void _writeTaggedLocationClasses(
    StringBuffer buffer,
    List<_TreeFieldSource> fields,
  ) {
    for (final field in fields) {
      if (field is! _TreeTaggedListsSource || !field.generateLocation) {
        continue;
      }
      final key = field.key;
      _writeLocationClass(buffer, field.locationType, [
        _TreeParam(type: field.categoryType, name: field.discriminator),
        if (key != null)
          _TreeParam(type: key.type, name: key.field)
        else
          _TreeParam(type: 'int', name: field.indexField),
      ]);
    }
  }

  void _writeLocationClass(
    StringBuffer buffer,
    String name,
    List<_TreeParam> params,
  ) {
    if (buffer.toString().contains('final class $name {')) return;
    final eq = params.map((p) => 'other.${p.name} == ${p.name}').join(' && ');
    final hash = params.length == 1
        ? '${params.first.name}.hashCode'
        : 'Object.hash(${params.map((p) => p.name).join(', ')})';
    buffer
      ..writeln('final class $name {')
      ..writeln(
        '  const $name({${params.map((p) => 'required this.${p.name}').join(', ')}});',
      )
      ..writeln()
      ..writeAll(params.map((p) => '  final ${p.type} ${p.name};\n'))
      ..writeln()
      ..writeln('  @override')
      ..writeln('  bool operator ==(Object other) =>')
      ..writeln('      identical(this, other) || (other is $name && $eq);')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  int get hashCode => $hash;')
      ..writeln('}')
      ..writeln();
  }

  /// Per-leaf-lens extras: a saved-backing predicate and a [GeneratedEditField]
  /// metadata ref. Backing reuses the lens `get` — an out-of-range list index
  /// or a sealed-case mismatch on `saved` throws, which we read as "no backing"
  /// (the field is new in the draft). Root-scalar fields with no location key
  /// off the empty record `()`.
  void _writeFieldExtras(
    StringBuffer body,
    _TreeSchemaSource schema,
    String fieldEnum,
    List<_TreeLens> lenses,
  ) {
    final rootType = schema.rootType;
    for (final lens in lenses) {
      final params = lens.path.params;
      // Three shapes: no params (root scalar); a single location object
      // (generated int-`{...}Location`, or an explicit discriminator location
      // from `taggedLists`); or multiple positional
      // params (a list nested under a discriminator — no single-arg form).
      final noLocation = params.isEmpty;
      final singleLocation =
          !noLocation && (lens.path.usesLocation || params.length == 1);
      final locType = lens.path.usesLocation
          ? lens.path.locationType
          : (params.length == 1 ? params.single.type : null);

      final String savedParams;
      final String lensArgs;
      if (noLocation) {
        savedParams = '$rootType? saved';
        lensArgs = '';
      } else if (singleLocation) {
        savedParams = '$rootType? saved, $locType location';
        lensArgs = 'location';
      } else {
        savedParams = '$rootType? saved, ${lens.path.lensParams}';
        lensArgs = params.map((param) => param.name).join(', ');
      }
      body
        ..writeln('bool ${lens.name}HasSavedBacking($savedParams) {')
        ..writeln('  if (saved == null) return false;')
        ..writeln('  try {')
        ..writeln('    ${lens.name}Lens($lensArgs).get(saved);')
        ..writeln('    return true;')
        ..writeln('  } on Object catch (_) {')
        ..writeln('    return false;')
        ..writeln('  }')
        ..writeln('}')
        ..writeln();

      // A GeneratedEditField needs a single location type, so emit a ref only
      // for the no-location and single-location shapes.
      if (!noLocation && !singleLocation) continue;
      final type = lens.type;
      final adapterExpr = lens.prop.adapter.expression(type);
      final refLocType = noLocation ? '()' : locType;
      final lensRef = noLocation
          ? '(location) => ${lens.name}Lens()'
          : '${lens.name}Lens';
      body
        ..writeln('final ${lens.name}Field =')
        ..writeln(
          '    GeneratedEditField<$rootType, $refLocType, $type, '
          'Lens<$rootType, $type>>(',
        )
        ..writeln("      id: '${lens.name}',")
        ..writeln('      dirtyField: $fieldEnum.${lens.name},')
        ..writeln('      lens: $lensRef,')
        ..writeln('      fallback: null,');
      if (lens.prop.defaultSource != null) {
        body.writeln('      defaultValue: ${lens.prop.defaultSource},');
      }
      body
        ..writeln('      adapter: $adapterExpr,')
        ..writeln('    );')
        ..writeln();
    }
  }

  void _writeStructuralLenses(
    StringBuffer buffer,
    List<_TreeStructuralLens> lenses,
  ) {
    final seen = <String>{};
    for (final lens in lenses) {
      if (lens.name.isEmpty || !seen.add(lens.name)) continue;
      final params = lens.path.lensParams;
      buffer
        ..writeln(
          'Lens<${lens.path.rootType}, ${lens.type}> ${lens.name}Lens($params) =>',
        )
        ..writeln('    ${lens.path.lensBase};');
      if (params.isEmpty) buffer.writeln();
      buffer
        ..writeln()
        ..write('${lens.type}? ${lens.name}At(${lens.path.rootType}? root');
      if (params.isNotEmpty) buffer.write(', $params');
      buffer
        ..writeln(') {')
        ..writeln('  if (root == null) return null;')
        ..writeln('  final lens = ${lens.name}Lens(${lens.path.lensArgs});')
        ..writeln('  try {')
        ..writeln('    if (!lens.canGet(root)) return null;')
        ..writeln('    return lens.get(root);')
        ..writeln('  } on Object catch (_) {')
        ..writeln('    return null;')
        ..writeln('  }')
        ..writeln('}')
        ..writeln();
    }
  }

  void _collectFields(
    StringBuffer parts,
    List<_TreeLens> lenses,
    List<_TreeStructuralLens> structuralLenses,
    Map<String, _TreeNodeSource> comparableNodes,
    List<_TreeFieldSource> fields,
    String ownerType,
    InterfaceElement owner,
    _TreePath path, {
    required String rootId,
  }) {
    for (final field in fields) {
      switch (field) {
        case _TreePropSource():
          if (field.readOnly) continue;
          final pathName = _pascal(path.nameParts.join());
          final part = '_$rootId$pathName${_pascal(field.name)}Part';
          _writePropPart(parts, part, ownerType, field);
          final nextPath = path.append(
            part: part,
            valueExpr: '${path.valueExpr}?.${field.property}',
            name: field.name,
          );
          lenses.add(
            _TreeLens(
              name: nextPath.lensName,
              type: field.type,
              path: nextPath,
              prop: field,
              receiver: path.valueExpr,
            ),
          );
        case _TreeChildSource():
          final pathName = _pascal(path.nameParts.join());
          final part = '_$rootId$pathName${_pascal(field.name)}Part';
          _writeChildPart(parts, part, ownerType, field);
          final nextValue = field.nullable
              ? '${path.valueExpr}?.${field.property}'
              : '${path.valueExpr}?.${field.property}';
          final nextPath = path.append(
            part: part,
            valueExpr: nextValue,
            name: field.name,
            scope: field.scope,
          );
          final structuralPath = path.append(
            part: part,
            valueExpr: nextValue,
            name: field.name,
          );
          if (structuralPath.params.isEmpty) {
            structuralLenses.add(
              _TreeStructuralLens(
                name: structuralPath.lensName,
                type: field.type,
                path: structuralPath,
              ),
            );
          }
          comparableNodes[field.node.type] = field.node;
          _collectFields(
            parts,
            lenses,
            structuralLenses,
            comparableNodes,
            field.node.fields,
            field.type,
            field.element,
            nextPath,
            rootId: rootId,
          );
          _collectNodeCases(
            parts,
            lenses,
            structuralLenses,
            comparableNodes,
            field.node,
            field.type,
            nextPath,
            rootId,
          );
        case _TreeListSource():
          final pathName = _pascal(path.nameParts.join());
          final part = '_$rootId$pathName${_pascal(field.name)}ItemPart';
          final listPart = '_$rootId$pathName${_pascal(field.name)}Part';
          final indexName = field.indexField ?? '${_singular(field.name)}Index';
          _writeListAggregatePart(parts, listPart, ownerType, field);
          _writeListPart(parts, part, ownerType, field);
          _writeTreeListHelpers(parts, ownerType, field);

          final String accessor;
          final List<_TreeParam> nextParams;
          String? nextRootExpr;
          String? nextLocationName;
          if (field.location != null) {
            // Mixed-param fold: inherited location param(s) + this list's index
            // collapse into one named location object (e.g.
            // `ActionLocation { GestureLocation gesture; int actionIndex; }`).
            // Each inherited param is re-accessed as `location.<field>` and the
            // dispatcher in `rootExpr` is rewritten to match.
            final parentField = field.parentField ?? 'parent';
            accessor = 'location.$indexName';
            nextLocationName = field.location;
            nextRootExpr = path.rootExpr;
            final folded = <_TreeParam>[];
            for (final param in path.params) {
              final fieldName = param.type == 'int' ? param.name : parentField;
              nextRootExpr = nextRootExpr!.replaceAll(
                RegExp(r'\b' + RegExp.escape(param.accessor) + r'\b'),
                'location.$fieldName',
              );
              folded.add(
                _TreeParam(
                  type: param.type,
                  name: fieldName,
                  accessor: 'location.$fieldName',
                ),
              );
            }
            nextParams = [
              ...folded,
              _TreeParam(type: 'int', name: indexName, accessor: accessor),
            ];
          } else {
            // Int-only path -> generated `{...}Location`; a path already carrying
            // a non-int param keeps positional index params.
            final locationMode = path.params.every(
              (param) => param.type == 'int',
            );
            accessor = locationMode ? 'location.$indexName' : indexName;
            nextParams = [
              ...path.params,
              _TreeParam(type: 'int', name: indexName, accessor: accessor),
            ];
          }

          final nextPath = path.append(
            part: '$part($accessor)',
            valueExpr:
                '(${path.valueExpr}?.${field.property} ?? const <${field.elementType}>[])',
            name: _singular(field.name),
            scope: field.scope,
            params: nextParams,
            rootExpr: nextRootExpr,
            locationName: nextLocationName,
          );
          final listPath = path.append(
            part: listPart,
            valueExpr:
                '(${path.valueExpr}?.${field.property} ?? const <${field.elementType}>[])',
            name: field.name,
          );
          structuralLenses.add(
            _TreeStructuralLens(
              name: listPath.lensName,
              type: 'List<${field.elementType}>',
              path: listPath,
            ),
          );
          structuralLenses.add(
            _TreeStructuralLens(
              name: nextPath.lensName,
              type: field.elementType,
              path: nextPath,
            ),
          );
          comparableNodes[field.node.type] = field.node;
          _collectFields(
            parts,
            lenses,
            structuralLenses,
            comparableNodes,
            field.node.fields,
            field.elementType,
            field.element,
            nextPath,
            rootId: rootId,
          );
          _collectNodeCases(
            parts,
            lenses,
            structuralLenses,
            comparableNodes,
            field.node,
            field.elementType,
            nextPath,
            rootId,
          );
        case _TreeSealedSource():
          final pathName = _pascal(path.nameParts.join());
          final casePart = '_$rootId$pathName${_pascal(field.name)}Part';
          comparableNodes[field.type] = _TreeNodeSource(
            type: field.type,
            element: field.element,
            fields: const [],
            shared: field.shared,
            cases: field.cases,
          );
          _writeChildPart(
            parts,
            casePart,
            ownerType,
            _TreeChildSource(
              id: field.id,
              name: field.name,
              property: field.property,
              type: field.type,
              element: field.element,
              node: _TreeNodeSource(
                type: field.type,
                element: field.element,
                fields: const [],
                shared: field.shared,
                cases: field.cases,
              ),
              nullable: false,
            ),
          );
          for (final shared in field.shared) {
            final prop = _TreePropSource(
              id: shared.property,
              name: shared.property,
              property: shared.property,
              type: shared.type,
              compare: shared.compare,
              adapter: const _AdapterSource._(kind: _AdapterKind.identity),
              readOnly: false,
              orElseSource: shared.orElseSource,
            );
            final part =
                '_$rootId$pathName${_pascal(field.name)}${_pascal(prop.name)}Part';
            _writePropPart(parts, part, field.type, prop);
            final nextPath = path
                .append(
                  part: casePart,
                  valueExpr: '${path.valueExpr}?.${field.property}',
                  name: field.name,
                  structural: true,
                )
                .append(
                  part: part,
                  valueExpr:
                      '${path.valueExpr}?.${field.property}.${prop.property}',
                  name: prop.name,
                );
            lenses.add(
              _TreeLens(
                name: nextPath.lensName,
                type: prop.type,
                path: nextPath,
                prop: prop,
                receiver: '${path.valueExpr}?.${field.property}',
              ),
            );
          }
          for (final caseSource in field.cases) {
            final castPart = '_$rootId${pathName}As${caseSource.caseType}Part';
            _writeCastPart(parts, castPart, field.type, caseSource.caseType);
            final nextPath = path
                .append(
                  part: casePart,
                  valueExpr: '${path.valueExpr}?.${field.property}',
                  name: field.name,
                  structural: true,
                )
                .append(
                  part: castPart,
                  valueExpr: '${path.valueExpr}?.${field.property}',
                  name: caseSource.tag,
                  scope: caseSource.scope,
                  structural: true,
                );
            _collectFields(
              parts,
              lenses,
              structuralLenses,
              comparableNodes,
              caseSource.fields,
              caseSource.caseType,
              caseSource.caseElement,
              nextPath,
              rootId: rootId,
            );
          }
        case _TreeTaggedListsSource():
          _writeTaggedLens(parts, rootId, ownerType, field);
          _writeTaggedListHelpers(parts, ownerType, field);
          final dispatcher = '${field.lensName}(location)';
          final locationParam = _TreeParam(
            type: field.locationType,
            name: 'location',
          );
          // Shared fields, declared once over the element supertype, yield a
          // single `{baseName}{Field}Lens(Location)` family.
          final sharedPath = _TreePath(
            rootType: ownerType,
            rootExpr: dispatcher,
            params: [locationParam],
            nameParts: [field.baseName],
            parts: const [],
            valueExpr: 'null',
          );
          _collectFields(
            parts,
            lenses,
            structuralLenses,
            comparableNodes,
            field.shared,
            field.elementType,
            field.sharedOwner,
            sharedPath,
            rootId: rootId,
          );
          // Per-entry case fields, reached by casting the supertype to the
          // entry type.
          for (final entry in field.entries) {
            comparableNodes[entry.node.type] = entry.node;
            final entryCast = '_$rootId${_pascal(entry.baseName)}CastPart';
            _writeCastPart(
              parts,
              entryCast,
              field.elementType,
              entry.elementType,
            );
            // A per-entry node `id` becomes the display-name scope for its
            // whole subtree; without one, each case scopes itself.
            final entryScope = entry.node.id;
            final entryPath = _TreePath(
              rootType: ownerType,
              rootExpr: dispatcher,
              params: [locationParam],
              nameParts: [_singular(entry.baseName)],
              displayParts: entryScope != null ? [entryScope] : null,
              scoped: entryScope != null,
              parts: [entryCast],
              valueExpr: 'null',
            );
            _collectFields(
              parts,
              lenses,
              structuralLenses,
              comparableNodes,
              entry.node.fields,
              entry.elementType,
              entry.node.element,
              entryPath,
              rootId: rootId,
            );
            for (final caseSource in entry.node.cases) {
              final castPart = '_${rootId}As${caseSource.caseType}Part';
              _writeCastPart(
                parts,
                castPart,
                entry.elementType,
                caseSource.caseType,
              );
              final casePath = entryPath.append(
                part: castPart,
                valueExpr: 'null',
                name: caseSource.tag,
                scope: caseSource.scope,
                structural: true,
              );
              _collectFields(
                parts,
                lenses,
                structuralLenses,
                comparableNodes,
                caseSource.fields,
                caseSource.caseType,
                caseSource.caseElement,
                casePath,
                rootId: rootId,
              );
            }
          }
        case _TreeDispatchSource():
          _writeDispatchLens(parts, ownerType, field);
          final dispatcher = '${field.lensName}(${field.paramName})';
          final categoryParam = _TreeParam(
            type: field.categoryType,
            name: field.paramName,
          );
          // The shared node, addressed by the category enum, yields a single
          // `{baseName}{Field}Lens(TCategory)` family over the dispatcher.
          final dispatchPath = _TreePath(
            rootType: ownerType,
            rootExpr: dispatcher,
            params: [categoryParam],
            nameParts: [field.baseName],
            parts: const [],
            valueExpr: 'null',
          );
          comparableNodes[field.node.type] = field.node;
          _collectFields(
            parts,
            lenses,
            structuralLenses,
            comparableNodes,
            field.node.fields,
            field.elementType,
            field.element,
            dispatchPath,
            rootId: rootId,
          );
          _collectNodeCases(
            parts,
            lenses,
            structuralLenses,
            comparableNodes,
            field.node,
            field.elementType,
            dispatchPath,
            rootId,
          );
      }
    }
  }

  void _collectNodeCases(
    StringBuffer parts,
    List<_TreeLens> lenses,
    List<_TreeStructuralLens> structuralLenses,
    Map<String, _TreeNodeSource> comparableNodes,
    _TreeNodeSource node,
    String ownerType,
    _TreePath path,
    String rootId,
  ) {
    if (node.shared.isNotEmpty) {
      for (final shared in node.shared) {
        final prop = _TreePropSource(
          id: shared.property,
          name: shared.property,
          property: shared.property,
          type: shared.type,
          compare: shared.compare,
          adapter: const _AdapterSource._(kind: _AdapterKind.identity),
          readOnly: false,
          orElseSource: shared.orElseSource,
        );
        final pathName = _pascal(path.nameParts.join());
        final part = '_$rootId$pathName${_pascal(prop.name)}Part';
        _writePropPart(parts, part, ownerType, prop);
        final nextPath = path.append(
          part: part,
          valueExpr: '${path.valueExpr}?.${prop.property}',
          name: prop.name,
        );
        lenses.add(
          _TreeLens(
            name: nextPath.lensName,
            type: prop.type,
            path: nextPath,
            prop: prop,
            receiver: path.valueExpr,
          ),
        );
      }
    }

    for (final caseSource in node.cases) {
      final pathName = _pascal(path.nameParts.join());
      final castPart = '_$rootId${pathName}As${caseSource.caseType}Part';
      _writeCastPart(parts, castPart, ownerType, caseSource.caseType);
      final casePath = path.append(
        part: castPart,
        valueExpr: path.valueExpr,
        name: caseSource.tag,
        scope: caseSource.scope,
        structural: true,
      );
      _collectFields(
        parts,
        lenses,
        structuralLenses,
        comparableNodes,
        caseSource.fields,
        caseSource.caseType,
        caseSource.caseElement,
        casePath,
        rootId: rootId,
      );
    }
  }

  void _writePropPart(
    StringBuffer buffer,
    String name,
    String ownerType,
    _TreePropSource field,
  ) {
    if (buffer.toString().contains('final $name = ')) return;
    buffer
      ..writeln('final $name = LensPart<$ownerType, ${field.type}>(')
      ..writeln('  get: (value) => ${field.getter('value')},')
      ..writeln('  set: (value, next) => ${field.setter('value', 'next')},')
      ..writeln("  name: '${field.name}',")
      ..writeln(');')
      ..writeln();
  }

  void _writeChildPart(
    StringBuffer buffer,
    String name,
    String ownerType,
    _TreeChildSource field,
  ) {
    if (buffer.toString().contains('final $name = ')) return;
    final read = field.nullable
        ? '${field.getter('value')} ?? const ${field.type}()'
        : field.getter('value');
    var write = field.setter('value', 'next');
    if (field.nullable && field.node.compactSource != null) {
      write =
          '${field.node.compactSource!.replaceAll('value', 'next')} ? ${field.setter('value', 'null')} : $write';
    }
    buffer
      ..writeln('final $name = LensPart<$ownerType, ${field.type}>(')
      ..writeln('  get: (value) => $read,')
      ..writeln('  set: (value, next) => $write,')
      ..writeln("  name: '${field.name}',")
      ..writeln(');')
      ..writeln();
  }

  void _writeListAggregatePart(
    StringBuffer buffer,
    String name,
    String ownerType,
    _TreeListSource field,
  ) {
    if (buffer.toString().contains('final $name = ')) return;
    buffer
      ..writeln(
        'final $name = LensPart<$ownerType, List<${field.elementType}>>(',
      )
      ..writeln('  get: (value) => value.${field.property},')
      ..writeln(
        '  set: (value, next) => value.copyWith(${field.property}: next),',
      )
      ..writeln("  name: '${field.name}',")
      ..writeln(');')
      ..writeln();
  }

  void _writeListPart(
    StringBuffer buffer,
    String name,
    String ownerType,
    _TreeListSource field,
  ) {
    if (buffer.toString().contains(
      'LensPart<$ownerType, ${field.elementType}> $name',
    )) {
      return;
    }
    buffer
      ..writeln(
        'LensPart<$ownerType, ${field.elementType}> $name(int index) =>',
      )
      ..writeln('    LensPart<$ownerType, ${field.elementType}>(')
      ..writeln('      get: (value) => value.${field.property}[index],')
      ..writeln('      set: (value, nextValue) {')
      ..writeln(
        '        if (index < 0 || index >= value.${field.property}.length) return value;',
      )
      ..writeln(
        '        final next = List<${field.elementType}>.of(value.${field.property});',
      )
      ..writeln('        next[index] = nextValue;')
      ..writeln('        return value.copyWith(${field.property}: next);')
      ..writeln('      },')
      ..writeln(
        '      canGet: (value) => index >= 0 && index < value.${field.property}.length,',
      )
      ..writeln("      name: '${field.name}[\$index]',")
      ..writeln('    );')
      ..writeln();
  }

  void _writeTreeListHelpers(
    StringBuffer buffer,
    String ownerType,
    _TreeListSource field,
  ) {
    final name = _pascal(_singular(field.name));
    final marker = '$ownerType replace${name}At(';
    if (buffer.toString().contains(marker)) return;
    final element = field.elementType;
    final read = 'root.${field.property}';
    final setter = 'root.copyWith(${field.property}: next)';

    buffer
      ..writeln(
        '$ownerType replace${name}At($ownerType root, int index, $element value) {',
      )
      ..writeln('  final list = $read;')
      ..writeln('  if (index < 0 || index >= list.length) return root;')
      ..writeln('  final next = List<$element>.of(list);')
      ..writeln('  next[index] = value;')
      ..writeln('  return $setter;')
      ..writeln('}')
      ..writeln()
      ..writeln(
        '$ownerType update${name}At($ownerType root, int index, $element Function($element value) update) {',
      )
      ..writeln('  final list = $read;')
      ..writeln('  if (index < 0 || index >= list.length) return root;')
      ..writeln('  final next = List<$element>.of(list);')
      ..writeln('  next[index] = update(next[index]);')
      ..writeln('  return $setter;')
      ..writeln('}')
      ..writeln()
      ..writeln(
        '$ownerType insert${name}At($ownerType root, int index, $element value) {',
      )
      ..writeln('  final list = $read;')
      ..writeln('  if (index < 0 || index > list.length) return root;')
      ..writeln('  final next = List<$element>.of(list)..insert(index, value);')
      ..writeln('  return $setter;')
      ..writeln('}')
      ..writeln()
      ..writeln('$ownerType add$name($ownerType root, $element value) {')
      ..writeln('  final next = List<$element>.of($read)..add(value);')
      ..writeln('  return $setter;')
      ..writeln('}')
      ..writeln()
      ..writeln('$ownerType remove${name}At($ownerType root, int index) {')
      ..writeln('  final list = $read;')
      ..writeln('  if (index < 0 || index >= list.length) return root;')
      ..writeln('  final next = List<$element>.of(list)..removeAt(index);')
      ..writeln('  return $setter;')
      ..writeln('}')
      ..writeln()
      ..writeln('$ownerType duplicate${name}At($ownerType root, int index) {')
      ..writeln('  final list = $read;')
      ..writeln('  if (index < 0 || index >= list.length) return root;')
      ..writeln(
        '  final next = List<$element>.of(list)..insert(index + 1, list[index]);',
      )
      ..writeln('  return $setter;')
      ..writeln('}')
      ..writeln()
      ..writeln('$ownerType move$name($ownerType root, int from, int to) {')
      ..writeln('  final list = $read;')
      ..writeln('  if (from < 0 || from >= list.length) return root;')
      ..writeln('  final next = List<$element>.of(list);')
      ..writeln('  final item = next.removeAt(from);')
      ..writeln('  next.insert(to.clamp(0, next.length), item);')
      ..writeln('  return $setter;')
      ..writeln('}')
      ..writeln();
  }

  void _writeCastPart(
    StringBuffer buffer,
    String name,
    String ownerType,
    String caseType,
  ) {
    if (buffer.toString().contains('final $name = ')) return;
    buffer
      ..writeln('final $name = LensPart<$ownerType, $caseType>(')
      ..writeln('  get: (value) => value as $caseType,')
      ..writeln('  canGet: (value) => value is $caseType,')
      ..writeln('  set: (value, next) => next,')
      ..writeln("  name: '$caseType',")
      ..writeln(');')
      ..writeln();
  }

  void _writeTaggedLens(
    StringBuffer buffer,
    String rootId,
    String rootType,
    _TreeTaggedListsSource source,
  ) {
    if (source.key != null) {
      _writeKeyedTaggedLens(buffer, rootId, rootType, source);
      return;
    }
    final element = source.elementType;
    final lensName = source.lensName;
    final disc = source.discriminator;
    final idx = source.indexField;
    if (buffer.toString().contains('Lens<$rootType, $element> $lensName(')) {
      return;
    }
    buffer
      ..writeln(
        'Lens<$rootType, $element> $lensName(${source.locationType} location) => '
        'Lens<$rootType, $element>(',
      )
      ..writeln('  get: (root) {')
      ..writeln('    final container = root as $rootType;')
      ..writeln('    return switch (location.$disc) {');
    for (final entry in source.entries) {
      buffer.writeln(
        '      ${entry.enumSource} => '
        'container.${entry.property}[location.$idx],',
      );
    }
    buffer
      ..writeln('    };')
      ..writeln('  },')
      ..writeln('  set: (root, nextValue) {')
      ..writeln('    final container = root as $rootType;')
      ..writeln('    return switch (location.$disc) {');
    for (final entry in source.entries) {
      buffer
        ..writeln('      ${entry.enumSource} => () {')
        ..writeln(
          '        final next = '
          'List<${entry.elementType}>.of(container.${entry.property});',
        )
        ..writeln(
          '        next[location.$idx] = nextValue as ${entry.elementType};',
        )
        ..writeln('        return container.copyWith(${entry.property}: next);')
        ..writeln('      }(),');
    }
    buffer
      ..writeln('    };')
      ..writeln('  },')
      ..writeln('  canGet: (root) {')
      ..writeln('    final container = root as $rootType;')
      ..writeln('    return switch (location.$disc) {');
    for (final entry in source.entries) {
      buffer.writeln(
        '      ${entry.enumSource} => '
        'location.$idx < container.${entry.property}.length,',
      );
    }
    buffer
      ..writeln('    };')
      ..writeln('  },')
      ..writeln(
        "  name: '${source.baseName}[\${location.$disc}/\${location.$idx}]',",
      )
      ..writeln(');')
      ..writeln();
  }

  /// Emits the identity-keyed variant of the tagged dispatcher: the location
  /// carries the element key, and get/set/canGet resolve it to an index per
  /// read through a shared `_{lens}IndexOf` scan. A key miss behaves like an
  /// out-of-range index (get throws, canGet is false, set is a no-op), so the
  /// saved-backing try/catch contract is unchanged.
  void _writeKeyedTaggedLens(
    StringBuffer buffer,
    String rootId,
    String rootType,
    _TreeTaggedListsSource source,
  ) {
    final element = source.elementType;
    final lensName = source.lensName;
    final disc = source.discriminator;
    final key = source.key!;
    final keyField = key.field;
    if (buffer.toString().contains('Lens<$rootType, $element> $lensName(')) {
      return;
    }

    final indexOf = '_${lensName}IndexOf';
    buffer
      ..writeln('int $indexOf(List<$element> list, ${key.type} key) {')
      ..writeln('  for (var i = 0; i < list.length; i++) {')
      ..writeln('    if (${key.getter('list[i]')} == key) return i;')
      ..writeln('  }')
      ..writeln('  return -1;')
      ..writeln('}')
      ..writeln()
      ..writeln(
        'Lens<$rootType, $element> $lensName(${source.locationType} location) => '
        'Lens<$rootType, $element>(',
      )
      ..writeln('  get: (root) {')
      ..writeln('    final container = root as $rootType;')
      ..writeln('    return switch (location.$disc) {');
    for (final entry in source.entries) {
      buffer.writeln(
        '      ${entry.enumSource} => container.${entry.property}'
        '[$indexOf(container.${entry.property}, location.$keyField)],',
      );
    }
    buffer
      ..writeln('    };')
      ..writeln('  },')
      ..writeln('  set: (root, nextValue) {')
      ..writeln('    final container = root as $rootType;')
      ..writeln('    return switch (location.$disc) {');
    for (final entry in source.entries) {
      buffer
        ..writeln('      ${entry.enumSource} => () {')
        ..writeln(
          '        final index = '
          '$indexOf(container.${entry.property}, location.$keyField);',
        )
        ..writeln('        if (index < 0) return container;')
        ..writeln(
          '        final next = '
          'List<${entry.elementType}>.of(container.${entry.property});',
        )
        ..writeln('        next[index] = nextValue as ${entry.elementType};')
        ..writeln('        return container.copyWith(${entry.property}: next);')
        ..writeln('      }(),');
    }
    buffer
      ..writeln('    };')
      ..writeln('  },')
      ..writeln('  canGet: (root) {')
      ..writeln('    final container = root as $rootType;')
      ..writeln('    return switch (location.$disc) {');
    for (final entry in source.entries) {
      buffer.writeln(
        '      ${entry.enumSource} => '
        '$indexOf(container.${entry.property}, location.$keyField) >= 0,',
      );
    }
    buffer
      ..writeln('    };')
      ..writeln('  },')
      ..writeln(
        "  name: '${source.baseName}"
        "[\${location.$disc}/#\${location.$keyField}]',",
      )
      ..writeln(');')
      ..writeln();
  }

  void _writeTaggedListHelpers(
    StringBuffer buffer,
    String rootType,
    _TreeTaggedListsSource source,
  ) {
    final element = source.elementType;
    final singular = _singular(source.baseName);
    final singularName = _pascal(singular);
    final plural = _plural(singular);
    final pluralName = _pascal(plural);
    final disc = source.discriminator;
    final discName = _pascal(disc);
    final location = source.locationType;
    final key = source.key;
    final indexExpr = key == null
        ? 'location.${source.indexField}'
        : '_${source.lensName}IndexOf(list, location.${key.field})';
    if (buffer.toString().contains('$element? ${singular}At(')) return;

    buffer
      ..writeln(
        'List<$element> ${plural}For$discName($rootType root, ${source.categoryType} $disc) =>',
      )
      ..writeln('    switch ($disc) {');
    for (final entry in source.entries) {
      buffer.writeln(
        '      ${entry.enumSource} => root.${entry.property}.cast<$element>(),',
      );
    }
    buffer
      ..writeln('      _ => const <$element>[],')
      ..writeln('    };')
      ..writeln()
      ..writeln(
        '$rootType with$pluralName'
        'For$discName($rootType root, ${source.categoryType} $disc, List<$element> values) =>',
      )
      ..writeln('    switch ($disc) {');
    for (final entry in source.entries) {
      buffer.writeln(
        '      ${entry.enumSource} => root.copyWith(${entry.property}: values.cast<${entry.elementType}>()),',
      );
    }
    buffer
      ..writeln('      _ => root,')
      ..writeln('    };')
      ..writeln()
      ..writeln(
        '$element? ${singular}At($rootType? root, $location location) {',
      )
      ..writeln('  if (root == null) return null;')
      ..writeln('  final lens = ${source.lensName}(location);')
      ..writeln('  try {')
      ..writeln('    if (!lens.canGet(root)) return null;')
      ..writeln('    return lens.get(root);')
      ..writeln('  } on Object catch (_) {')
      ..writeln('    return null;')
      ..writeln('  }')
      ..writeln('}')
      ..writeln()
      ..writeln(
        'int? ${singular}IndexOf($rootType? root, $location location) {',
      )
      ..writeln('  if (root == null) return null;')
      ..writeln('  final list = ${plural}For$discName(root, location.$disc);')
      ..writeln('  final index = $indexExpr;')
      ..writeln('  return index < 0 || index >= list.length ? null : index;')
      ..writeln('}')
      ..writeln()
      ..writeln(
        '$location? ${singular}LocationAt($rootType? root, ${source.categoryType} $disc, int index) {',
      )
      ..writeln('  if (root == null) return null;')
      ..writeln('  final list = ${plural}For$discName(root, $disc);')
      ..writeln('  if (index < 0 || index >= list.length) return null;');
    if (key == null) {
      buffer.writeln(
        '  return $location($disc: $disc, ${source.indexField}: index);',
      );
    } else {
      buffer
        ..writeln('  final key = ${key.getter('list[index]')};')
        ..writeln('  if (key == null) return null;')
        ..writeln('  return $location($disc: $disc, ${key.field}: key);');
    }
    buffer
      ..writeln('}')
      ..writeln();
    if (key != null) {
      buffer
        ..writeln(
          '$location? ${singular}LocationOf(${source.categoryType} $disc, $element value) {',
        )
        ..writeln('  final key = ${key.getter('value')};')
        ..writeln('  if (key == null) return null;')
        ..writeln('  return $location($disc: $disc, ${key.field}: key);')
        ..writeln('}')
        ..writeln();
    }
    buffer
      ..writeln(
        '$rootType add$singularName($rootType root, ${source.categoryType} $disc, $element value) =>',
      )
      ..writeln('    switch ($disc) {');
    for (final entry in source.entries) {
      buffer.writeln(
        '      ${entry.enumSource} => root.copyWith(${entry.property}: List<${entry.elementType}>.of(root.${entry.property})..add(value as ${entry.elementType})),',
      );
    }
    buffer
      ..writeln('      _ => root,')
      ..writeln('    };')
      ..writeln()
      ..writeln(
        '$rootType insert${singularName}At($rootType root, ${source.categoryType} $disc, int index, $element value) {',
      )
      ..writeln('  final list = ${plural}For$discName(root, $disc);')
      ..writeln('  if (index < 0 || index > list.length) return root;')
      ..writeln('  return switch ($disc) {');
    for (final entry in source.entries) {
      buffer.writeln(
        '    ${entry.enumSource} => root.copyWith(${entry.property}: List<${entry.elementType}>.of(root.${entry.property})..insert(index, value as ${entry.elementType})),',
      );
    }
    buffer
      ..writeln('    _ => root,')
      ..writeln('  };')
      ..writeln('}')
      ..writeln()
      ..writeln(
        '$rootType replace$singularName($rootType root, $location location, $element value) {',
      )
      ..writeln('  final index = ${singular}IndexOf(root, location);')
      ..writeln('  if (index == null) return root;')
      ..writeln('  return switch (location.$disc) {');
    for (final entry in source.entries) {
      buffer.writeln(
        '    ${entry.enumSource} => root.copyWith(${entry.property}: List<${entry.elementType}>.of(root.${entry.property})..[index] = value as ${entry.elementType}),',
      );
    }
    buffer
      ..writeln('    _ => root,')
      ..writeln('  };')
      ..writeln('}')
      ..writeln()
      ..writeln(
        '$rootType update$singularName($rootType root, $location location, $element Function($element value) update) {',
      )
      ..writeln('  final value = ${singular}At(root, location);')
      ..writeln('  if (value == null) return root;')
      ..writeln('  return replace$singularName(root, location, update(value));')
      ..writeln('}')
      ..writeln()
      ..writeln(
        '$rootType remove$singularName($rootType root, $location location) {',
      )
      ..writeln('  final index = ${singular}IndexOf(root, location);')
      ..writeln('  if (index == null) return root;')
      ..writeln('  return switch (location.$disc) {');
    for (final entry in source.entries) {
      buffer.writeln(
        '    ${entry.enumSource} => root.copyWith(${entry.property}: List<${entry.elementType}>.of(root.${entry.property})..removeAt(index)),',
      );
    }
    buffer
      ..writeln('    _ => root,')
      ..writeln('  };')
      ..writeln('}')
      ..writeln()
      ..writeln(
        '$rootType move$singularName($rootType root, ${source.categoryType} $disc, int from, int to) {',
      )
      ..writeln('  final list = ${plural}For$discName(root, $disc);')
      ..writeln('  if (from < 0 || from >= list.length) return root;')
      ..writeln('  final next = List<$element>.of(list);')
      ..writeln('  final item = next.removeAt(from);')
      ..writeln('  next.insert(to.clamp(0, next.length), item);')
      ..writeln(
        '  return with$pluralName'
        'For$discName(root, $disc, next);',
      )
      ..writeln('}')
      ..writeln();
  }

  /// Emits the section dispatcher for a [dispatch] node: a
  /// `Lens<TRoot, TNode>(TCategory)` that reads `root.<branch> ?? const TNode()` and
  /// writes back through `copyWith`, compacting an empty value to `null` when
  /// the node declares `compactWhen`. Categories absent from the branch map
  /// read a `const TNode()` and ignore writes.
  void _writeDispatchLens(
    StringBuffer buffer,
    String rootType,
    _TreeDispatchSource field,
  ) {
    final element = field.elementType;
    final lensName = field.lensName;
    final param = field.paramName;
    if (buffer.toString().contains('Lens<$rootType, $element> $lensName(')) {
      return;
    }
    final compact = field.node.compactSource;
    buffer
      ..writeln(
        'Lens<$rootType, $element> $lensName(${field.categoryType} $param) => '
        'Lens<$rootType, $element>(',
      )
      ..writeln('  get: (root) {')
      ..writeln('    final container = root as $rootType;')
      ..writeln('    return switch ($param) {');
    for (final branch in field.branches) {
      buffer.writeln(
        '      ${branch.enumSource} => '
        'container.${branch.property} ?? const $element(),',
      );
    }
    buffer
      ..writeln('      _ => const $element(),')
      ..writeln('    };')
      ..writeln('  },')
      ..writeln('  set: (root, next) {')
      ..writeln('    final container = root as $rootType;')
      ..writeln('    return switch ($param) {');
    for (final branch in field.branches) {
      final write = compact != null
          ? '${compact.replaceAll('value', 'next')} '
                '? container.copyWith(${branch.property}: null) '
                ': container.copyWith(${branch.property}: next)'
          : 'container.copyWith(${branch.property}: next)';
      buffer.writeln('      ${branch.enumSource} => $write,');
    }
    buffer
      ..writeln('      _ => container,')
      ..writeln('    };')
      ..writeln('  },')
      ..writeln("  name: '${field.baseName}[\${$param.name}]',")
      ..writeln(');')
      ..writeln();
  }

  void _writeComparableNode(StringBuffer buffer, _TreeNodeSource node) {
    final fnName = _comparableValueName(node.type);
    if (buffer.toString().contains('Object? $fnName(')) return;
    if (node.cases.isNotEmpty) {
      buffer.writeln(
        'Object? $fnName(${node.type}? value) => switch (value) {',
      );
      for (final caseSource in node.cases) {
        buffer.writeln('  ${caseSource.caseType}() && final v => [');
        for (final field in node.fields) {
          _writeComparableFieldProjection(buffer, field, 'v');
        }
        buffer
          ..writeAll(
            node.shared.map(
              (field) => '    ${field.projection('v', nullSafe: false)},\n',
            ),
          )
          ..writeln("    '${caseSource.tag}',");
        for (final field in caseSource.fields) {
          _writeComparableFieldProjection(buffer, field, 'v');
        }
        buffer.writeln('  ],');
      }
      buffer
        ..writeln('  _ => null,')
        ..writeln('};')
        ..writeln();
      return;
    }

    buffer.writeln('Object? $fnName(${node.type}? value) => [');
    for (final field in node.fields) {
      _writeComparableFieldProjection(buffer, field, 'value');
    }
    buffer
      ..writeln('];')
      ..writeln();
  }

  /// Emits one `comparable{Node}{Group}Value(Node?)` tuple per declared group —
  /// a named subset of the node's fields, projected with the same rules as the
  /// whole-node comparable. Single source for section-level dirty comparison.
  void _writeNodeGroups(StringBuffer buffer, _TreeNodeSource node) {
    for (final group in node.groups) {
      final fnName = 'comparable${node.type}${_pascal(group.id)}Value';
      if (buffer.toString().contains('Object? $fnName(')) continue;
      buffer.writeln('Object? $fnName(${node.type}? value) => [');
      for (final memberId in group.members) {
        _TreeFieldSource? member;
        for (final field in node.fields) {
          if (field.name == memberId || field.id == memberId) {
            member = field;
            break;
          }
        }
        if (member == null) {
          throw InvalidGenerationSourceError(
            'Group "${group.id}" references unknown field "$memberId" on '
            '${node.type}.',
          );
        }
        _writeComparableFieldProjection(buffer, member, 'value');
      }
      buffer
        ..writeln('];')
        ..writeln();
    }
  }

  void _writeComparableFieldProjection(
    StringBuffer buffer,
    _TreeFieldSource field,
    String receiver,
  ) {
    switch (field) {
      case _TreePropSource():
        buffer.writeln(
          '  ${_fieldProjection(field, receiver, nullSafe: receiver == 'value')},',
        );
      case _TreeChildSource():
        buffer.writeln(
          '  ${_comparableValueName(field.type)}($receiver?.${field.property}),',
        );
      case _TreeListSource():
        buffer.writeln(
          '  ($receiver?.${field.property} ?? const <${field.elementType}>[]).map(${_comparableValueName(field.elementType)}).toList(),',
        );
      case _TreeSealedSource():
        buffer.writeln(
          '  ${_comparableValueName(field.type)}($receiver?.${field.property}),',
        );
      case _TreeTaggedListsSource():
        for (final entry in field.entries) {
          buffer.writeln(
            '  ($receiver?.${entry.property} ?? const <${entry.elementType}>[]).map(${_comparableValueName(entry.elementType)}).toList(),',
          );
        }
      case _TreeDispatchSource():
        for (final branch in field.branches) {
          buffer.writeln(
            '  ${_comparableValueName(field.elementType)}($receiver?.${branch.property}),',
          );
        }
    }
  }
}

String _fieldProjection(
  _TreePropSource field,
  String receiver, {
  required bool nullSafe,
}) {
  if (field.compare.kind == _CompareKind.projected) {
    final source = nullSafe
        ? field.compare.projectSource!
        : field.compare.projectSource!.replaceAll('value?.', '$receiver.');
    return source.replaceAll(RegExp(r'\bvalue\b'), receiver);
  }
  // A select prop reads through its `get` closure (covers cases lacking the
  // property), not a bare `receiver.property`.
  final access = field.getSource != null
      ? field.getter(receiver)
      : (nullSafe
            ? '$receiver?.${field.property}'
            : '$receiver.${field.property}');
  if (field.compare.kind == _CompareKind.composed) {
    final element = _listElementType(field.type);
    if (element != null) {
      return '($access ?? const <$element>[]).map(${_comparableValueName(element)}).toList()';
    }
    return '${_comparableValueName(field.type)}($access)';
  }
  return field.orElseSource == null
      ? access
      : '$access ?? ${field.orElseSource}';
}
