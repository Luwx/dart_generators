part of 'edit_schema_source_generator.dart';

// ---------------------------------------------------------------------------
// valueSchema(...) — comparison-only value projections.
// ---------------------------------------------------------------------------

final class _ValueSchemaSource {
  const _ValueSchemaSource({
    required this.valueType,
    required this.flatFields,
    required this.shared,
    required this.cases,
  });

  factory _ValueSchemaSource.parse(MethodInvocation node) {
    final valueType = _typeArguments(node, count: 1)[0];
    final valueElement = _interfaceElementOfTypeArg(node, 0);

    final flatFields = _optionalListArgument(node, 'fields')
        .map((expr) => _ValueFieldSource.parse(expr, valueElement))
        .toList(growable: false);
    final shared = _optionalListArgument(node, 'shared')
        .map((expr) => _ValueFieldSource.parse(expr, valueElement))
        .toList(growable: false);
    final cases = _optionalListArgument(
      node,
      'cases',
    ).map(_ValueCaseSource.parse).toList(growable: false);

    if (cases.isEmpty && flatFields.isEmpty) {
      throw _unsupported(node, 'valueSchema needs fields or cases.');
    }
    if (cases.isEmpty && shared.isNotEmpty) {
      throw _unsupported(node, 'shared fields require cases.');
    }

    return _ValueSchemaSource(
      valueType: valueType,
      flatFields: flatFields,
      shared: shared,
      cases: cases,
    );
  }

  final String valueType;
  final List<_ValueFieldSource> flatFields;
  final List<_ValueFieldSource> shared;
  final List<_ValueCaseSource> cases;

  bool get isSealed => cases.isNotEmpty;
}

final class _ValueCaseSource {
  const _ValueCaseSource({
    required this.caseType,
    required this.tag,
    required this.fields,
  });

  factory _ValueCaseSource.parse(Expression expression) {
    final node = _asInvocation(expression, 'valueCase');
    final caseType = _typeArguments(node, count: 1)[0];
    final caseElement = _maybeInterfaceElementOfTypeArg(node, 0);
    final tag = _stringLiteral(_firstPositionalArgument(node));
    final fields = _optionalListArgument(node, 'fields')
        .map((expr) => _ValueFieldSource.parse(expr, caseElement))
        .toList(growable: false);
    return _ValueCaseSource(caseType: caseType, tag: tag, fields: fields);
  }

  final String caseType;
  final String tag;
  final List<_ValueFieldSource> fields;
}

final class _ValueFieldSource {
  const _ValueFieldSource({
    required this.property,
    required this.type,
    required this.compare,
    this.orElseSource,
  });

  factory _ValueFieldSource.parse(
    Expression expression,
    InterfaceElement? ownerElement,
  ) {
    final node = _asInvocation(expression, 'prop');
    final id = _stringLiteral(_firstPositionalArgument(node));
    final property = _optionalStringArgument(node, 'property') ?? id;

    final compareArg = _namedArgument(node, 'compare')?.expression;
    final isComposed =
        compareArg != null && _callName(compareArg) == 'composed';
    final resolved = ownerElement == null
        ? null
        : _fieldTypeOrNull(ownerElement, property);
    final type =
        _explicitPropFieldType(node) ??
        resolved ??
        // composed()/list mapping needs the real element type; a scalar or
        // collection projection only emits `receiver?.property`, so the exact
        // type is irrelevant and may be an extension getter (e.g. an effective
        // value) that is not a class member. Any mismatch surfaces when the
        // generated file is compiled.
        (isComposed
            ? throw _unsupported(
                node,
                'valueSchema prop "$property" uses composed() but its type does '
                'not resolve on ${ownerElement?.name ?? 'the owner'}; add an '
                'explicit type argument.',
              )
            : 'Object?');
    return _ValueFieldSource(
      property: property,
      type: type,
      compare: _compareFor(node, type),
      orElseSource: _namedArgument(node, 'orElse')?.expression.toSource(),
    );
  }

  final String property;
  final String type;
  final _CompareSource compare;

  /// Source of the `orElse:` default, emitted as `… ?? <orElseSource>` for
  /// scalar/collection comparisons. Null when no default was given.
  final String? orElseSource;

  /// The comparable expression for this field, reading [receiver] (e.g.
  /// `value?.speed` or `v.motion`). [nullSafe] selects `?.`/`.` access.
  String projection(String receiver, {required bool nullSafe}) {
    final access = nullSafe ? '$receiver?.$property' : '$receiver.$property';
    switch (compare.kind) {
      case _CompareKind.projected:
        // projectSource is written in terms of a nullable `value`; rebind to
        // the receiver. In a non-null (sealed case) context also drop the
        // null-aware access so `value?.x` becomes `v.x`.
        final source = nullSafe
            ? compare.projectSource!
            : compare.projectSource!.replaceAll('value?.', '$receiver.');
        return source.replaceAll(RegExp(r'\bvalue\b'), receiver);
      case _CompareKind.composed:
        final element = _listElementType(type);
        if (element != null) {
          final fallback = nullSafe ? '$access ?? const <$element>[]' : access;
          return '($fallback).map(${_comparableValueName(element)}).toList()';
        }
        return '${_comparableValueName(type)}($access)';
      case _CompareKind.scalar:
      case _CompareKind.deepCollection:
        return orElseSource == null ? access : '$access ?? $orElseSource';
    }
  }
}

final class _ValueSchemaEmitter {
  const _ValueSchemaEmitter();

  String emit(_ValueSchemaSource schema) {
    final type = schema.valueType;
    final fnName = _comparableValueName(type);
    final buffer = StringBuffer()
      ..writeln('// Generated code. Do not modify by hand.')
      ..writeln(
        '// ignore_for_file: dead_code, prefer_null_aware_operators, '
        'lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, '
        'unnecessary_parenthesis, unreachable_switch_case',
      )
      ..writeln();

    if (!schema.isSealed) {
      buffer
        ..writeln('Object? $fnName($type? value) => [')
        ..writeAll(
          schema.flatFields.map(
            (field) => '  ${field.projection('value', nullSafe: true)},\n',
          ),
        )
        ..writeln('];');
      return buffer.toString();
    }

    buffer.writeln('Object? $fnName($type? value) => switch (value) {');
    for (final caseSource in schema.cases) {
      buffer
        ..writeln('  ${caseSource.caseType}() && final v => [')
        ..writeln("    '${caseSource.tag}',")
        ..writeAll(
          schema.shared.map(
            (field) => '    ${field.projection('v', nullSafe: false)},\n',
          ),
        )
        ..writeAll(
          caseSource.fields.map(
            (field) => '    ${field.projection('v', nullSafe: false)},\n',
          ),
        )
        ..writeln('  ],');
    }
    buffer
      ..writeln('  _ => null,')
      ..writeln('};');
    return buffer.toString();
  }
}
