import 'package:edit_schema_generator/edit_schema_generator.dart';

import 'edit_schema_test_models.dart';

part 'tearoff_self_union_fixture.g.dart';

Lens<FixtureVariant> fixtureVariantLens(FixtureLocation location) {
  throw UnimplementedError('Only generated helper signatures use this lens.');
}

Lens<FixtureNode> tearoffNodeLens(FixtureLocation location) {
  throw UnimplementedError('Only generated helper signatures use this lens.');
}

// Tear-off get/set, used to verify the generator accepts function references
// (no forwarding closure, no `unnecessary_lambdas`).
String? readMode(FixtureNode node) => node.mode;
FixtureNode writeMode(FixtureNode node, String? mode) =>
    node.copyWith(mode: mode);

// Self-union: the root value *is* the sealed case, so no `caseLens` is needed.
@GenerateEditSchema()
final EditSchema<FixtureVariant, FixtureLocation> variantSelfSchema =
    editSchema<FixtureVariant, FixtureLocation>(
      id: 'variant',
      rootLens: 'fixtureVariantLens',
      fields: [
        union<TextVariant>('self', fields: [prop('text')]),
        union<ListVariant>('self', fields: [prop('items', compare: deep())]),
      ],
    );

// Tear-off get/set in a leaf lens override.
@GenerateEditSchema()
final EditSchema<FixtureNode, FixtureLocation> tearoffNodeSchema =
    editSchema<FixtureNode, FixtureLocation>(
      id: 'tearoffNode',
      rootLens: 'tearoffNodeLens',
      fields: [
        prop(
          'mode',
          select: lens(get: readMode, set: writeMode),
        ),
      ],
    );
