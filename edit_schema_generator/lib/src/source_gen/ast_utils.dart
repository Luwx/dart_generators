part of 'edit_schema_source_generator.dart';

// ---------------------------------------------------------------------------
// Shared AST parsing, type resolution, and string helpers.
// ---------------------------------------------------------------------------

String? _compactWhenSource(Expression? expression) {
  if (expression == null) return null;
  final function = _asFunctionExpression(expression);
  final body = function.body;
  if (body is! ExpressionFunctionBody) {
    throw _unsupported(expression, 'compactWhen must use expression syntax.');
  }
  final parameter = function.parameters?.parameters.firstOrNull?.name?.lexeme;
  if (parameter == null) {
    throw _unsupported(expression, 'compactWhen needs one parameter.');
  }
  return body.expression.toSource().replaceAll(
    RegExp(r'\b' + RegExp.escape(parameter) + r'\b'),
    'value',
  );
}

InterfaceElement _interfaceElementFromStaticType(
  DartType type,
  Expression node,
) {
  final base = type is InterfaceType ? type : null;
  if (base != null) return base.element;
  throw _unsupported(node, 'Expected an interface type.');
}

DartType _fieldDartType(
  InterfaceElement classElement,
  String fieldName,
  Expression token,
) {
  for (final element in _selfAndSupertypes(classElement)) {
    final field = element.getField(fieldName);
    if (field != null) return field.type;
    final getter = element.getGetter(fieldName);
    if (getter != null) return getter.returnType;
  }
  throw _unsupported(
    token,
    'Field "$fieldName" was not found on ${classElement.name}.',
  );
}

String _singular(String value) {
  if (value.endsWith('ies')) return '${value.substring(0, value.length - 3)}y';
  if (value.endsWith('s')) return value.substring(0, value.length - 1);
  return value;
}

/// `comparable{Type}Value`, stripping nullability from [type].
String _comparableValueName(String type) {
  final base = type.endsWith('?') ? type.substring(0, type.length - 1) : type;
  return 'comparable${base}Value';
}

/// The element type of a `List<T>` source string, or null if not a list.
String? _listElementType(String type) {
  final match = RegExp(r'^List<(.+)>$').firstMatch(type);
  return match?.group(1);
}

MethodInvocation _asInvocation(Expression expression, String expectedName) {
  if (expression is MethodInvocation &&
      expression.methodName.name == expectedName) {
    return expression;
  }
  throw _unsupported(expression, 'Expected $expectedName(...).');
}

List<String> _typeArguments(MethodInvocation node, {required int count}) {
  final arguments = node.typeArguments?.arguments;
  if (arguments == null || arguments.length != count) {
    throw _unsupported(node, '${node.methodName.name} needs $count type args.');
  }
  return arguments.map((type) => type.toSource()).toList(growable: false);
}

Expression _requiredArgument(MethodInvocation node, String name) {
  final argument = _namedArgument(node, name);
  if (argument == null) {
    throw _unsupported(node, 'Missing required argument "$name".');
  }
  return argument.expression;
}

NamedExpression? _namedArgument(MethodInvocation node, String name) {
  for (final argument in node.argumentList.arguments) {
    if (argument is NamedExpression && argument.name.label.name == name) {
      return argument;
    }
  }
  return null;
}

Expression _firstPositionalArgument(MethodInvocation node) {
  for (final argument in node.argumentList.arguments) {
    if (argument is! NamedExpression) return argument;
  }
  throw _unsupported(node, 'Missing positional argument.');
}

String _fallbackSource(Expression expression) {
  final arguments = _argumentList(expression)?.arguments;
  final argument = arguments?.whereType<Expression>().firstWhereOrNull(
    (argument) => argument is! NamedExpression,
  );
  if (argument == null) {
    throw _unsupported(expression, 'fallback requires a projection function.');
  }
  final function = _asFunctionExpression(argument);
  final body = function.body;
  if (body is! ExpressionFunctionBody) {
    throw _unsupported(argument, 'Fallback must use expression syntax.');
  }
  final parameter = function.parameters?.parameters.firstOrNull?.name?.lexeme;
  if (parameter == null) {
    throw _unsupported(argument, 'Fallback needs one parameter.');
  }
  return body.expression.toSource().replaceAll(
    RegExp(r'\b' + RegExp.escape(parameter) + r'\b'),
    'value',
  );
}

/// Reads the predicate closure of a `backedWhen(...)` call, rewriting its single
/// parameter to the `saved` variable used by the generated backing function.
String _backingPredicateSource(Expression expression) {
  final arguments = _argumentList(expression)?.arguments;
  final argument = arguments?.whereType<Expression>().firstWhereOrNull(
    (argument) => argument is! NamedExpression,
  );
  if (argument == null) {
    throw _unsupported(expression, 'backedWhen requires a predicate function.');
  }
  final function = _asFunctionExpression(argument);
  final body = function.body;
  if (body is! ExpressionFunctionBody) {
    throw _unsupported(argument, 'backedWhen must use expression syntax.');
  }
  final parameter = function.parameters?.parameters.firstOrNull?.name?.lexeme;
  if (parameter == null) {
    throw _unsupported(argument, 'backedWhen needs one parameter.');
  }
  return body.expression.toSource().replaceAll(
    RegExp(r'\b' + RegExp.escape(parameter) + r'\b'),
    'saved',
  );
}

_CompareSource _compareFor(MethodInvocation node, String type) {
  final compare = _namedArgument(node, 'compare');
  return compare == null
      ? _CompareSource.defaultFor(type)
      : _CompareSource.parse(compare.expression);
}

_RestoreSource _restoreFor(MethodInvocation node, _RestoreKind fallback) {
  final restore = _namedArgument(node, 'restore');
  return restore == null
      ? _RestoreSource(kind: fallback)
      : _RestoreSource.parse(restore.expression);
}

/// Extracts the source of an override closure argument (e.g. `get`/`set`),
/// rewriting its positional parameters to [placeholders] in order.
String _closureArgSource(
  MethodInvocation node,
  String argName,
  List<String> placeholders,
) {
  final argument = _requiredArgument(node, argName);
  // Accept a tear-off / function reference (e.g. `get: _readMotion`): apply it
  // to the placeholders so callers can avoid forwarding closures (which would
  // trip `unnecessary_lambdas`).
  if (argument is! FunctionExpression) {
    return '${argument.toSource()}(${placeholders.join(', ')})';
  }
  final function = argument;
  final body = function.body;
  if (body is! ExpressionFunctionBody) {
    throw _unsupported(function, 'Override functions must use => syntax.');
  }
  final parameters = function.parameters?.parameters ?? const [];
  var source = body.expression.toSource();
  for (var i = 0; i < placeholders.length && i < parameters.length; i++) {
    final name = parameters[i].name?.lexeme;
    if (name == null) continue;
    source = source.replaceAll(
      RegExp(r'\b' + RegExp.escape(name) + r'\b'),
      placeholders[i],
    );
  }
  return source;
}

/// Resolves the [InterfaceElement] of a method invocation's type argument.
InterfaceElement _interfaceElementOfTypeArg(MethodInvocation node, int index) {
  final element = _maybeInterfaceElementOfTypeArg(node, index);
  if (element == null) {
    throw _unsupported(
      node,
      'Type argument #$index does not resolve to an interface.',
    );
  }
  return element;
}

InterfaceElement? _maybeInterfaceElementOfTypeArg(
  MethodInvocation node,
  int index,
) {
  final arguments = node.typeArguments?.arguments;
  if (arguments == null || index >= arguments.length) {
    throw _unsupported(node, 'Missing type argument #$index.');
  }
  final type = arguments[index].type;
  return type is InterfaceType ? type.element : null;
}

String? _explicitPropFieldType(MethodInvocation node) {
  final arguments = node.typeArguments?.arguments;
  if (arguments == null || arguments.isEmpty) return null;
  return arguments.last.toSource();
}

/// Reads the declared type of [fieldName] on [classElement] as source text.
///
/// Walks [classElement] and its supertypes (superclass, mixins, interfaces) so
/// that members declared on a generated mixin are found. Freezed models keep
/// their field getters on the `_$Foo` mixin rather than on the hand-written
/// `Foo` class, so a direct `getGetter` on the class would miss them.
String _fieldType(
  InterfaceElement classElement,
  String fieldName,
  Expression token,
) {
  final type = _fieldTypeOrNull(classElement, fieldName);
  if (type != null) return type;
  throw _unsupported(
    token,
    'Field "$fieldName" was not found on ${classElement.name}.',
  );
}

/// As [_fieldType], but returns null instead of throwing when the member is not
/// found on [classElement] or its supertypes. Note this only sees class members
/// (including generated mixins), not extension getters.
String? _fieldTypeOrNull(InterfaceElement classElement, String fieldName) {
  for (final element in _selfAndSupertypes(classElement)) {
    final field = element.getField(fieldName);
    if (field != null) return field.type.getDisplayString();

    final getter = element.getGetter(fieldName);
    if (getter != null) return getter.returnType.getDisplayString();
  }
  return null;
}

/// [element] followed by every supertype's element (superclass, mixins,
/// interfaces), used to find members declared on generated mixins.
Iterable<InterfaceElement> _selfAndSupertypes(InterfaceElement element) sync* {
  yield element;
  for (final supertype in element.allSupertypes) {
    yield supertype.element;
  }
}

/// The field type implied by a `select: lens(get: ...)` override, read from the
/// `get` closure's (resolved) return type. Returns null when [access] is absent
/// or its `get` type does not resolve. Lets dispatched fields whose property
/// lives only on sealed subtypes (not the root) resolve a type without an
/// explicit type argument.
String? _lensGetReturnType(Expression? access) {
  if (access == null) return null;
  final lensNode = _asInvocation(access, 'lens');
  final getArgument = _namedArgument(lensNode, 'get')?.expression;
  final getType = getArgument?.staticType;
  if (getType is FunctionType) {
    return getType.returnType.getDisplayString();
  }
  return null;
}

String _lowerFirst(String value) =>
    value.isEmpty ? value : value[0].toLowerCase() + value.substring(1);

String _stringArgument(MethodInvocation node, String name) =>
    _stringLiteral(_requiredArgument(node, name));

String? _optionalStringArgument(MethodInvocation node, String name) {
  final argument = _namedArgument(node, name);
  if (argument == null) return null;
  return _stringLiteral(argument.expression);
}

bool _boolArgument(MethodInvocation node, String name, {required bool orElse}) {
  final argument = _namedArgument(node, name)?.expression;
  if (argument == null) return orElse;
  if (argument is BooleanLiteral) return argument.value;
  throw _unsupported(argument, 'Argument "$name" must be a boolean literal.');
}

List<Expression> _listArgument(MethodInvocation node, String name) {
  final expression = _requiredArgument(node, name);
  if (expression is ListLiteral) {
    return expression.elements.whereType<Expression>().toList(growable: false);
  }
  throw _unsupported(expression, 'Argument "$name" must be a list literal.');
}

List<Expression> _optionalListArgument(MethodInvocation node, String name) {
  final argument = _namedArgument(node, name);
  if (argument == null) return const [];
  final expression = argument.expression;
  if (expression is ListLiteral) {
    return expression.elements.whereType<Expression>().toList(growable: false);
  }
  throw _unsupported(expression, 'Argument "$name" must be a list literal.');
}

String _stringLiteral(Expression expression) {
  if (expression is SimpleStringLiteral) return expression.value;
  if (expression is AdjacentStrings) {
    return expression.strings.map(_stringLiteral).join();
  }
  final metaName = _metaConstName(expression);
  if (metaName != null) return metaName;
  throw _unsupported(
    expression,
    'Expected a string literal or a <Class>Meta name constant.',
  );
}

/// Resolves a generated `<Class>Meta` name constant to its string value so
/// schemas can use typo-safe field/method names instead of raw literals.
///
/// Read purely from the AST — independent of build ordering between the meta
/// and schema generators — relying on meta_generator's contract: a member
/// constant's name equals its value (`SpeedSettingsMeta.events` -> 'events'),
/// keyword-escaped names carry a leading `$` to strip (`FooMeta.$default` ->
/// 'default'), and `self` is the class name, i.e. the meta type minus `Meta`
/// (`CommandActionMeta.self` -> 'CommandAction'). Existence is still enforced by
/// the Dart compiler when the schema library is analyzed.
String? _metaConstName(Expression expression) {
  final String target;
  final String member;
  if (expression is PrefixedIdentifier) {
    target = expression.prefix.name;
    member = expression.identifier.name;
  } else if (expression is PropertyAccess &&
      expression.target is SimpleIdentifier) {
    target = (expression.target! as SimpleIdentifier).name;
    member = expression.propertyName.name;
  } else {
    return null;
  }
  if (!target.endsWith('Meta')) return null;
  if (member == 'self') {
    return target.substring(0, target.length - 'Meta'.length);
  }
  return member.startsWith(r'$') ? member.substring(1) : member;
}

String _inferCaseField(Expression getCaseExpression) {
  final function = _asFunctionExpression(getCaseExpression);
  final body = function.body;
  if (body is! ExpressionFunctionBody) {
    throw _unsupported(
      getCaseExpression,
      'getCase must use expression syntax.',
    );
  }
  final expression = body.expression;
  if (expression is! PrefixedIdentifier) {
    throw _unsupported(
      expression,
      'Could not infer case field. Pass caseField explicitly.',
    );
  }
  return expression.identifier.name;
}

String _projectedSource(Expression expression) {
  final arguments = _argumentList(expression)?.arguments;
  final namedProject = arguments?.whereType<NamedExpression>().firstWhereOrNull(
    (argument) => argument.name.label.name == 'project',
  );
  final argument =
      namedProject?.expression ??
      arguments?.whereType<Expression>().firstWhereOrNull(
        (argument) => argument is! NamedExpression,
      );
  if (argument == null) {
    throw _unsupported(
      expression,
      'Compare.projected requires a projection function.',
    );
  }
  final function = _asFunctionExpression(argument);
  final body = function.body;
  if (body is! ExpressionFunctionBody) {
    throw _unsupported(
      argument,
      'Projected compare must use expression syntax.',
    );
  }
  final parameter = function.parameters?.parameters.firstOrNull?.name?.lexeme;
  if (parameter == null) {
    throw _unsupported(argument, 'Projected compare needs one parameter.');
  }
  return body.expression.toSource().replaceAll(
    RegExp(r'\b' + parameter + r'\b'),
    'value',
  );
}

FunctionExpression _asFunctionExpression(Expression expression) {
  if (expression is FunctionExpression) return expression;
  throw _unsupported(expression, 'Expected a function expression.');
}

String? _callName(Expression expression) {
  if (expression is MethodInvocation) return expression.methodName.name;
  if (expression is InstanceCreationExpression) {
    return expression.constructorName.name?.name;
  }
  return null;
}

ArgumentList? _argumentList(Expression expression) {
  if (expression is MethodInvocation) return expression.argumentList;
  if (expression is InstanceCreationExpression) return expression.argumentList;
  return null;
}

InvalidGenerationSourceError _unsupported(AstNode node, String message) {
  return InvalidGenerationSourceError(
    '$message\nUnsupported source: ${node.toSource()}',
  );
}

String _pascal(String value) {
  return value
      .split(RegExp('[^A-Za-z0-9]+'))
      .where((part) => part.isNotEmpty)
      .map((part) => part[0].toUpperCase() + part.substring(1))
      .join();
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return null;
    return iterator.current;
  }

  T? firstWhereOrNull(bool Function(T value) test) {
    for (final value in this) {
      if (test(value)) return value;
    }
    return null;
  }
}
