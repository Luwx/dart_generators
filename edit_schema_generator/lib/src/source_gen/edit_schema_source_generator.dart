import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:edit_schema_generator/src/source_gen/edit_schema_annotations.dart';
import 'package:source_gen/source_gen.dart';

part 'ast_utils.dart';
part 'edit_root_source.dart';
part 'edit_root_emitter.dart';
part 'tree_source.dart';
part 'tree_emitter.dart';
part 'value_schema.dart';
part 'list_schema.dart';

class EditSchemaSourceGenerator
    extends GeneratorForAnnotation<GenerateEditSchema> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! TopLevelVariableElement) {
      throw InvalidGenerationSourceError(
        '@GenerateEditSchema can only annotate top-level schema variables.',
        element: element,
      );
    }

    final variable = await _findVariableDeclaration(element);
    final initializer = variable.initializer;
    if (initializer is! MethodInvocation) {
      throw InvalidGenerationSourceError(
        'Annotated schema variables must be initialized with editRoot(...) or '
        'editSchema(...).',
        element: element,
      );
    }

    switch (initializer.methodName.name) {
      case 'editRoot':
        final schema = _EditRootSource.parse(initializer);
        return const _SourceSchemaEmitter().emit(schema);
      case 'editSchema':
        // The token surface references generated `*Field` enums from other
        // libraries, so it needs a resolved AST to read field types off the
        // root and case class elements.
        final resolvedVariable = await _findResolvedVariableDeclaration(
          element,
        );
        final resolvedInit = resolvedVariable.initializer;
        if (resolvedInit is! MethodInvocation) {
          throw InvalidGenerationSourceError(
            'Could not resolve editSchema(...) initializer for ${element.name}.',
            element: element,
          );
        }
        final schema = _EditRootSource.parseSchema(resolvedInit);
        return const _SourceSchemaEmitter().emit(schema);
      case 'valueSchema':
        // Needs a resolved AST to read field/case types off the value type.
        final resolvedVariable = await _findResolvedVariableDeclaration(
          element,
        );
        final resolvedInit = resolvedVariable.initializer;
        if (resolvedInit is! MethodInvocation) {
          throw InvalidGenerationSourceError(
            'Could not resolve valueSchema(...) initializer for '
            '${element.name}.',
            element: element,
          );
        }
        final schema = _ValueSchemaSource.parse(resolvedInit);
        return const _ValueSchemaEmitter().emit(schema);
      case 'listSchema':
        final schema = _ListSchemaSource.parse(initializer);
        return const _ListSchemaEmitter().emit(schema);
      case 'editTree':
        final resolvedVariable = await _findResolvedVariableDeclaration(
          element,
        );
        final resolvedInit = resolvedVariable.initializer;
        if (resolvedInit is! MethodInvocation) {
          throw InvalidGenerationSourceError(
            'Could not resolve editTree(...) initializer for ${element.name}.',
            element: element,
          );
        }
        final library = await _resolvedLibrary(element);
        final schema = _TreeSchemaSource.parse(
          resolvedInit,
          _TreeParseContext.fromLibrary(library),
        );
        return const _TreeSchemaEmitter().emit(schema);
      default:
        throw InvalidGenerationSourceError(
          'Annotated schema variables must be initialized with editRoot(...), '
          'editSchema(...), valueSchema(...), listSchema(...), or editTree(...).',
          element: element,
        );
    }
  }
}

Future<ResolvedLibraryResult> _resolvedLibrary(
  TopLevelVariableElement element,
) async {
  final session = element.library.session;
  final result = await session.getResolvedLibraryByElement(element.library);
  if (result is! ResolvedLibraryResult) {
    throw InvalidGenerationSourceError(
      'Could not resolve library for ${element.name}.',
      element: element,
    );
  }
  return result;
}

Future<VariableDeclaration> _findVariableDeclaration(
  TopLevelVariableElement element,
) async {
  final session = element.library.session;
  final result = session.getParsedLibraryByElement(element.library);
  if (result is! ParsedLibraryResult) {
    throw InvalidGenerationSourceError(
      'Could not parse library for ${element.name}.',
      element: element,
    );
  }

  for (final unit in result.units) {
    for (final declaration in unit.unit.declarations) {
      if (declaration is! TopLevelVariableDeclaration) continue;
      for (final variable in declaration.variables.variables) {
        if (variable.name.lexeme == element.name) {
          return variable;
        }
      }
    }
  }

  throw InvalidGenerationSourceError(
    'Could not find source declaration for ${element.name}.',
    element: element,
  );
}

Future<VariableDeclaration> _findResolvedVariableDeclaration(
  TopLevelVariableElement element,
) async {
  final session = element.library.session;
  final result = await session.getResolvedLibraryByElement(element.library);
  if (result is! ResolvedLibraryResult) {
    throw InvalidGenerationSourceError(
      'Could not resolve library for ${element.name}.',
      element: element,
    );
  }

  for (final unit in result.units) {
    for (final declaration in unit.unit.declarations) {
      if (declaration is! TopLevelVariableDeclaration) continue;
      for (final variable in declaration.variables.variables) {
        if (variable.name.lexeme == element.name) {
          return variable;
        }
      }
    }
  }

  throw InvalidGenerationSourceError(
    'Could not find resolved declaration for ${element.name}.',
    element: element,
  );
}
