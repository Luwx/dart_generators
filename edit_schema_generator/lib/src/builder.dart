import 'package:build/build.dart';
import 'package:edit_schema_generator/src/source_gen/edit_schema_source_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder editSchemaBuilder(BuilderOptions options) {
  return SharedPartBuilder([EditSchemaSourceGenerator()], 'edit_schema');
}
