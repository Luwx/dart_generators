import 'package:edit_schema_generator/edit_schema_generator.dart';
import 'package:test/test.dart';

void main() {
  test('exports schema APIs', () {
    expect(GenerateEditSchema, isA<Type>());
    expect(GeneratedEditField, isA<Type>());
  });
}
