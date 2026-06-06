part of 'edit_schema_source_generator.dart';

// ---------------------------------------------------------------------------
// listSchema(...) — guarded copy-on-write list mutation helpers.
// ---------------------------------------------------------------------------

final class _ListSchemaSource {
  const _ListSchemaSource({
    required this.rootType,
    required this.elementType,
    required this.property,
    required this.id,
    this.getSource,
    this.setSource,
  });

  factory _ListSchemaSource.parse(MethodInvocation node) {
    final typeArguments = _typeArguments(node, count: 2);
    final property = _stringArgument(node, 'property');

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

    return _ListSchemaSource(
      rootType: typeArguments[0],
      elementType: typeArguments[1],
      property: property,
      id: _optionalStringArgument(node, 'id') ?? property,
      getSource: getSource,
      setSource: setSource,
    );
  }

  final String rootType;
  final String elementType;
  final String property;
  final String id;
  final String? getSource;
  final String? setSource;

  String getter(String root) =>
      (getSource ?? r'$root.' + property).replaceAll(r'$root', root);

  String setter(String root, String next) =>
      (setSource ?? r'$root.copyWith(' + property + r': $next)')
          .replaceAll(r'$root', root)
          .replaceAll(r'$next', next);
}

final class _ListSchemaEmitter {
  const _ListSchemaEmitter();

  String emit(_ListSchemaSource schema) {
    final root = schema.rootType;
    final element = schema.elementType;
    final name = _pascal(schema.id);
    final listOf = 'List<$element>.of(${schema.getter('root')})';
    final read = schema.getter('root');

    final buffer = StringBuffer()
      ..writeln('// Generated code. Do not modify by hand.')
      ..writeln(
        '// ignore_for_file: dead_code, prefer_null_aware_operators, '
        'lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, '
        'unnecessary_parenthesis, unreachable_switch_case',
      )
      ..writeln();

    // replace{Name}At
    buffer
      ..writeln(
        '$root replace${name}At($root root, int index, $element value) {',
      )
      ..writeln('  final list = $read;')
      ..writeln('  if (index < 0 || index >= list.length) return root;')
      ..writeln('  final next = List<$element>.of(list);')
      ..writeln('  next[index] = value;')
      ..writeln('  return ${schema.setter('root', 'next')};')
      ..writeln('}')
      ..writeln();

    // update{Name}At
    buffer
      ..writeln(
        '$root update${name}At($root root, int index, '
        '$element Function($element value) update) {',
      )
      ..writeln('  final list = $read;')
      ..writeln('  if (index < 0 || index >= list.length) return root;')
      ..writeln('  final next = List<$element>.of(list);')
      ..writeln('  next[index] = update(next[index]);')
      ..writeln('  return ${schema.setter('root', 'next')};')
      ..writeln('}')
      ..writeln();

    // insert{Name}At
    buffer
      ..writeln(
        '$root insert${name}At($root root, int index, $element value) {',
      )
      ..writeln('  final list = $read;')
      ..writeln('  if (index < 0 || index > list.length) return root;')
      ..writeln('  final next = List<$element>.of(list)..insert(index, value);')
      ..writeln('  return ${schema.setter('root', 'next')};')
      ..writeln('}')
      ..writeln();

    // add{Name}
    buffer
      ..writeln('$root add$name($root root, $element value) {')
      ..writeln('  final next = $listOf..add(value);')
      ..writeln('  return ${schema.setter('root', 'next')};')
      ..writeln('}')
      ..writeln();

    // remove{Name}At
    buffer
      ..writeln('$root remove${name}At($root root, int index) {')
      ..writeln('  final list = $read;')
      ..writeln('  if (index < 0 || index >= list.length) return root;')
      ..writeln('  final next = List<$element>.of(list)..removeAt(index);')
      ..writeln('  return ${schema.setter('root', 'next')};')
      ..writeln('}')
      ..writeln();

    // duplicate{Name}At
    buffer
      ..writeln('$root duplicate${name}At($root root, int index) {')
      ..writeln('  final list = $read;')
      ..writeln('  if (index < 0 || index >= list.length) return root;')
      ..writeln(
        '  final next = List<$element>.of(list)'
        '..insert(index + 1, list[index]);',
      )
      ..writeln('  return ${schema.setter('root', 'next')};')
      ..writeln('}')
      ..writeln();

    // move{Name}
    buffer
      ..writeln('$root move$name($root root, int from, int to) {')
      ..writeln('  final list = $read;')
      ..writeln('  if (from < 0 || from >= list.length) return root;')
      ..writeln('  final next = List<$element>.of(list);')
      ..writeln('  final item = next.removeAt(from);')
      ..writeln('  next.insert(to.clamp(0, next.length), item);')
      ..writeln('  return ${schema.setter('root', 'next')};')
      ..writeln('}');

    return buffer.toString();
  }
}
