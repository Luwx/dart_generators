import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';

// ---------------------------------------------------------------------------
// MetaGenerator
// ---------------------------------------------------------------------------

class MetaGenerator extends GeneratorForAnnotation<WithMeta> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@withMeta can only be applied to classes.',
        element: element,
      );
    }

    final buf = StringBuffer();
    for (final group in _metaGroups(element)) {
      _writeMeta(buf, group.name, group.fields, group.methods);
    }
    return buf.toString();
  }

  /// One generated meta per group. A regular or single-factory class yields a
  /// single group named after the class. A freezed *union* (several public
  /// redirecting factories) yields one group per case, named after the case's
  /// concrete type (`Action.command = CommandAction` -> `CommandActionMeta`), so
  /// callers reference case fields as `CommandActionMeta.command`.
  List<_MetaGroup> _metaGroups(ClassElement element) {
    final ownName = element.name ?? '';
    if (!_isFreezedClass(element)) {
      return [
        _MetaGroup(
          ownName,
          _extractRegularFields(element),
          _extractMethods(element),
        ),
      ];
    }

    final groups = <_MetaGroup>[];
    final seen = <String>{};
    for (final ctor in element.constructors) {
      // Each redirecting factory is either a union case (`= CommandAction`) or
      // the data-class impl factory (`= _Foo`); `fromJson` and the private
      // generative constructor don't redirect, so they fall out here.
      if (!ctor.isFactory) continue;
      final target = ctor.redirectedConstructor;
      if (target == null) continue;
      final targetName = target.returnType.element.name;
      final isCase = targetName != null && !targetName.startsWith('_');
      final name = isCase ? targetName : ownName;
      if (name.isEmpty || !seen.add(name)) continue;
      final fields = _params(ctor);
      groups.add(
        _MetaGroup(name, fields, isCase ? const [] : _extractMethods(element)),
      );
    }
    if (groups.isEmpty) {
      groups.add(
        _MetaGroup(ownName, _extractFreezedFields(element), _extractMethods(element)),
      );
    }
    return groups;
  }

  // -------------------------------------------------------------------------
  // Class analysis
  // -------------------------------------------------------------------------

  bool _isFreezedClass(ClassElement element) =>
      element.metadata.annotations.any((a) {
        final src = a.toSource();
        return src == '@freezed' || src.startsWith('@Freezed');
      });

  List<_Field> _params(ConstructorElement ctor) => ctor.formalParameters
      .where((p) => p.name != null && !p.name!.startsWith('_'))
      .map((p) => _Field(p.name!))
      .toList();

  List<_Field> _extractRegularFields(ClassElement element) => element.fields
      .where((f) => !f.isStatic && f.isPublic && f.name != null)
      .map((f) => _Field(f.name!))
      .toList();

  List<_Field> _extractFreezedFields(ClassElement element) {
    // Fields live on the primary redirecting factory's parameters.
    final factory = element.constructors
        .where(
          (c) =>
              c.isFactory &&
              c.redirectedConstructor != null &&
              c.formalParameters.isNotEmpty,
        )
        .firstOrNull;
    return factory == null ? const [] : _params(factory);
  }

  List<String> _extractMethods(ClassElement element) {
    const skip = {'noSuchMethod', 'toString', 'hashCode'};
    return element.methods
        .where(
          (m) =>
              !m.isStatic &&
              m.isPublic &&
              m.name != null &&
              !skip.contains(m.name),
        )
        .map((m) => m.name!)
        .toList();
  }

  // -------------------------------------------------------------------------
  // Code generation
  // -------------------------------------------------------------------------

  /// Emits one `${cls}Meta` of compile-time-safe name constants:
  /// `${cls}Meta.self` is the class/case name, `${cls}Meta.<member>` is that
  /// member's name string, and `props`/`methods` collect them (each omitted when
  /// empty). No enums or type metadata — just typo-safe name strings.
  void _writeMeta(
    StringBuffer buf,
    String cls,
    List<_Field> fields,
    List<String> methods,
  ) {
    // `abstract final` makes the meta a pure namespace: it can be neither
    // instantiated nor subtyped, so no constructor is needed.
    buf.writeln('abstract final class ${cls}Meta {');
    buf.writeln("  static const String self = '${_esc(cls)}';");
    if (fields.isNotEmpty || methods.isNotEmpty) buf.writeln();
    for (final f in fields) {
      buf.writeln("  static const String ${_id(f.name)} = '${_esc(f.name)}';");
    }
    for (final m in methods) {
      buf.writeln("  static const String ${_id(m)} = '${_esc(m)}';");
    }
    if (fields.isNotEmpty) {
      buf.writeln();
      final names = fields.map((f) => _id(f.name)).join(', ');
      buf.writeln('  static const List<String> props = [$names];');
    }
    if (methods.isNotEmpty) {
      buf.writeln();
      final names = methods.map(_id).join(', ');
      buf.writeln('  static const List<String> methods = [$names];');
    }
    buf.writeln('}');
    buf.writeln();
  }

  static const _keywords = {
    'assert', 'break', 'case', 'catch', 'class', 'const', 'continue',
    'default', 'do', 'else', 'enum', 'extends', 'false', 'final', 'finally',
    'for', 'if', 'in', 'is', 'new', 'null', 'rethrow', 'return', 'super',
    'switch', 'this', 'throw', 'true', 'try', 'var', 'void', 'while', 'with',
  };

  String _id(String name) => _keywords.contains(name) ? '\$$name' : name;
  String _esc(String s) => s.replaceAll("'", "\\'");
}

// ---------------------------------------------------------------------------
// Data
// ---------------------------------------------------------------------------

class _MetaGroup {
  _MetaGroup(this.name, this.fields, this.methods);

  final String name;
  final List<_Field> fields;
  final List<String> methods;
}

class _Field {
  _Field(this.name);

  final String name;
}
