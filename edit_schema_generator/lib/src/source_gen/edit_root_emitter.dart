part of 'edit_schema_source_generator.dart';

final class _SourceSchemaEmitter {
  const _SourceSchemaEmitter();

  String emit(_EditRootSource root) {
    final rootName = _pascal(root.id);
    final fieldEnum = '${rootName}DirtyField';
    final groupEnum = '${rootName}DirtyGroup';
    final buffer = StringBuffer()
      ..writeln('// Generated code. Do not modify by hand.')
      ..writeln(
        '// ignore_for_file: dead_code, prefer_null_aware_operators, '
        'lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, '
        'unnecessary_parenthesis, unreachable_switch_case, unused_element, '
        'invalid_null_aware_operator',
      )
      ..writeln()
      ..writeln('enum $fieldEnum {')
      ..writeAll(root.fields.map((field) => '  ${field.id},\n'))
      ..writeln('}')
      ..writeln();

    if (root.groups.isNotEmpty) {
      buffer
        ..writeln('enum $groupEnum {')
        ..writeAll(root.groups.map((group) => '  ${group.id},\n'))
        ..writeln('}')
        ..writeln();
    }

    _writeLensAccessors(buffer, root);
    _writeFieldRefs(buffer, root, fieldEnum);
    _writeComparableField(buffer, root, rootName, fieldEnum);
    if (root.groups.isNotEmpty) {
      _writeComparableGroup(buffer, root, rootName, groupEnum);
    }
    _writeRestoreField(buffer, root, rootName, fieldEnum);
    _writeSavedBacking(buffer, root);
    _writeFieldSavedBacking(buffer, root, fieldEnum);

    return buffer.toString();
  }

  void _writeFieldRefs(
    StringBuffer buffer,
    _EditRootSource root,
    String fieldEnum,
  ) {
    for (final field in root.fields) {
      if (field.isReadOnly) continue;
      final name = '${root.id}${_pascal(field.id)}Field';
      buffer
        ..writeln(
          'final $name = GeneratedEditField<${root.rootType}, '
          '${root.locationType}, ${field.type}, Lens<${field.type}>>(',
        )
        ..writeln("  id: '${field.id}',")
        ..writeln('  dirtyField: $fieldEnum.${field.id},')
        ..writeln('  lens: ${root.id}${_pascal(field.id)}Lens,')
        ..writeln('  fallback: ${_fallbackExpression(field)},')
        ..writeln('  adapter: ${field.adapter.expression(field.type)},')
        ..writeln(');')
        ..writeln();
    }
  }

  String _fallbackExpression(_EditFieldSource field) {
    switch (field.fallback.kind) {
      case _FallbackKind.none:
        return 'null';
      case _FallbackKind.custom:
        return '(value) => ${field.fallback.source}';
      case _FallbackKind.fromSelect:
        final selector = field.selector;
        if (selector is _LeafSource) {
          return '(value) => ${selector.getterExpression('value')}';
        }
        if (selector is _UnionSource) {
          return '(value) => switch (${selector.caseExpression('value')}) {'
              ' ${selector.caseType}() && final caseValue => '
              '${selector.getterExpression('caseValue')},'
              " _ => throw StateError('Fallback unavailable for field ${field.id}'),"
              ' }';
        }
    }
    throw StateError('Unsupported fallback for field ${field.id}.');
  }

  void _writeLensAccessors(StringBuffer buffer, _EditRootSource root) {
    final emittedUnionParts = <String>{};
    for (final field in root.fields) {
      if (field.isReadOnly) continue;
      final selector = field.selector;
      if (selector is _UnionSource) {
        final partName = '_${root.id}${_pascal(field.id)}Part';
        final castPartName = '_${root.id}As${selector.caseType}Part';
        if (emittedUnionParts.add(castPartName)) {
          buffer
            ..writeln(
              'final $castPartName = LensPart<${root.rootType}, '
              '${selector.caseType}>(',
            )
            ..writeln(
              '  get: (value) => '
              '${selector.caseExpression('value')} as ${selector.caseType},',
            )
            ..writeln(
              '  set: (value, next) => '
              '${selector.replaceCaseExpression('value', 'next')},',
            )
            ..writeln("  name: '${selector.caseType}',")
            ..writeln(');')
            ..writeln();
        }
        buffer
          ..writeln(
            'final $partName = LensPart<${selector.caseType}, '
            '${field.type}>(',
          )
          ..writeln('  get: (value) => ${selector.getterExpression('value')},')
          ..writeln(
            '  set: (value, next) => '
            '${selector.setterExpression('value', 'next')},',
          )
          ..writeln("  name: '${field.id}',")
          ..writeln(');')
          ..writeln()
          ..writeln(
            'Lens<${field.type}> ${root.id}${_pascal(field.id)}Lens('
            '${root.locationType} location) =>',
          )
          ..writeln('    ${root.rootLens}(location)')
          ..writeln('        .then($castPartName)')
          ..writeln('        .then($partName);')
          ..writeln();
      } else if (selector is _LeafSource) {
        final partName = '_${root.id}${_pascal(field.id)}Part';
        buffer
          ..writeln(
            'final $partName = LensPart<${root.rootType}, ${field.type}>(',
          )
          ..writeln('  get: (value) => ${selector.getterExpression('value')},')
          ..writeln(
            '  set: (value, next) => '
            '${selector.setterExpression('value', 'next')},',
          )
          ..writeln("  name: '${field.id}',")
          ..writeln(');')
          ..writeln()
          ..writeln(
            'Lens<${field.type}> ${root.id}${_pascal(field.id)}Lens('
            '${root.locationType} location) =>',
          )
          ..writeln('    ${root.rootLens}(location).then($partName);')
          ..writeln();
      }
    }
  }

  void _writeComparableField(
    StringBuffer buffer,
    _EditRootSource root,
    String rootName,
    String fieldEnum,
  ) {
    buffer
      ..writeln('Object? comparable${rootName}FieldValue(')
      ..writeln('  ${root.rootType}? value,')
      ..writeln('  $fieldEnum field,')
      ..writeln(') => switch (field) {');

    for (final field in root.fields) {
      final selector = field.selector;
      buffer.write('  $fieldEnum.${field.id} => ');
      if (field.compare.kind == _CompareKind.projected) {
        buffer.writeln('${field.compare.projectSource},');
      } else if (selector is _UnionSource) {
        buffer
          ..writeln('switch (value) {')
          ..writeln('    null => null,')
          ..writeln('    _ => switch (${selector.caseExpression('value')}) {')
          ..writeln(
            '      ${selector.caseType}() && final caseValue => '
            '${selector.getterExpression('caseValue')},',
          )
          ..writeln('      _ => null,')
          ..writeln('    },')
          ..writeln('  },');
      } else if (selector is _LeafSource) {
        buffer.writeln(
          'value == null ? null : ${selector.getterExpression('value')},',
        );
      }
    }

    buffer
      ..writeln('};')
      ..writeln();
  }

  void _writeComparableGroup(
    StringBuffer buffer,
    _EditRootSource root,
    String rootName,
    String groupEnum,
  ) {
    buffer
      ..writeln('Object? comparable${rootName}GroupValue(')
      ..writeln('  ${root.rootType}? value,')
      ..writeln('  $groupEnum group,')
      ..writeln(') => switch (group) {');

    for (final group in root.groups) {
      buffer
        ..writeln('  $groupEnum.${group.id} => [')
        ..writeAll(
          group.members.map(
            (member) =>
                '    comparable${rootName}FieldValue(value, '
                '${rootName}DirtyField.$member),\n',
          ),
        )
        ..writeln('  ],');
    }

    buffer
      ..writeln('};')
      ..writeln();
  }

  void _writeRestoreField(
    StringBuffer buffer,
    _EditRootSource root,
    String rootName,
    String fieldEnum,
  ) {
    buffer
      ..writeln('${root.rootType} restore${rootName}Field({')
      ..writeln('  required ${root.rootType} current,')
      ..writeln('  required ${root.rootType} saved,')
      ..writeln('  required $fieldEnum field,')
      ..writeln('}) => switch (field) {');

    for (final field in root.fields) {
      if (field.isReadOnly) {
        buffer.writeln('  $fieldEnum.${field.id} => current,');
        continue;
      }
      final selector = field.selector;
      buffer.write('  $fieldEnum.${field.id} => ');
      if (selector is _UnionSource) {
        buffer
          ..writeln(
            'switch ((${selector.caseExpression('current')}, '
            '${selector.caseExpression('saved')})) {',
          )
          ..writeln(
            '    (${selector.caseType}() && final currentValue, '
            '${selector.caseType}() && final savedValue) =>',
          )
          ..writeln(
            '      ${selector.replaceCaseExpression('current', selector.setterExpression('currentValue', selector.getterExpression('savedValue')))},',
          )
          ..writeln('    _ => current,')
          ..writeln('  },');
      } else if (selector is _LeafSource) {
        buffer.writeln(
          '${selector.setterExpression('current', selector.getterExpression('saved'))},',
        );
      }
    }

    buffer
      ..writeln('};')
      ..writeln();
  }

  void _writeSavedBacking(StringBuffer buffer, _EditRootSource root) {
    buffer
      ..writeln('bool ${root.id}HasSavedBacking(${root.rootType}? saved) =>')
      ..writeln('    ${root.savedBacking.source};');
  }

  /// Emits a per-field saved-backing resolver when any field declares a
  /// `backing:` override. Fields without an override fall back to the root
  /// predicate.
  void _writeFieldSavedBacking(
    StringBuffer buffer,
    _EditRootSource root,
    String fieldEnum,
  ) {
    if (!root.fields.any((field) => field.backing != null)) return;

    buffer
      ..writeln()
      ..writeln('bool ${root.id}FieldHasSavedBacking(')
      ..writeln('  ${root.rootType}? saved,')
      ..writeln('  $fieldEnum field,')
      ..writeln(') => switch (field) {');

    for (final field in root.fields) {
      final source = field.backing?.source ?? root.savedBacking.source;
      buffer.writeln('  $fieldEnum.${field.id} => $source,');
    }

    buffer.writeln('};');
  }
}
