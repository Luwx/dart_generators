import 'package:edit_schema_generator/edit_schema_generator.dart';

import 'edit_schema_test_models.dart';

part 'source_gen_fixture.g.dart';

Lens<FixtureNode, FixtureNode> fixtureNodeLens(FixtureLocation location) {
  throw UnimplementedError('Only generated helper signatures use this lens.');
}

Lens<FixtureDocument, FixtureNode> projectedFixtureNodeLens(
  FixtureLocation location,
) => Lens<FixtureDocument, FixtureNode>(
  get: (root) => root.nodes[location.index],
  set: (root, next) {
    final nodes = List<FixtureNode>.of(root.nodes);
    nodes[location.index] = next;
    return root.copyWith(nodes: nodes);
  },
  name: 'projectedFixtureNode[${location.index}]',
);

@GenerateEditSchema()
final EditSchema<FixtureNode, FixtureLocation> fixtureNodeGeneratedSchema =
    editSchema<FixtureNode, FixtureLocation>(
      fields: [
        union<TextVariant>(
          'variant',
          fields: [
            prop('text'),
            prop(
              'flag',
              compare: projected(
                (FixtureNode? value) => value?.variant is TextVariant
                    ? (value!.variant as TextVariant).effectiveFlag
                    : null,
              ),
            ),
          ],
        ),
        union<ListVariant>('variant', fields: [prop('items', compare: deep())]),
        prop('mode'),
        prop('labels', compare: deep()),
      ],
      groups: [
        editGroup(id: 'modeAndFlag', members: ['mode', 'flag']),
      ],
    );

@GenerateEditSchema()
final EditSchema<FixtureNode, FixtureLocation> projectedNodeGeneratedSchema =
    editSchema<FixtureNode, FixtureLocation>(
      id: 'projectedNode',
      rootLens: 'projectedFixtureNodeLens',
      fields: [
        prop('mode'),
      ],
    );
