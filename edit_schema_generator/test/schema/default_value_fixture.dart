import 'package:edit_schema_generator/edit_schema_generator.dart';

import 'default_value_test_models.dart';
import 'test_lens.dart';

part 'default_value_fixture.g.dart';

final taskNode = subtree<Task>(
  fields: [
    prop('title'),
    // Collapses the nullable `mode` onto its default so the lens is Lens<Mode>.
    prop('mode', defaultsTo: Mode.end),
    // Bool default exercises the `next == true` setter / generated-lint ignore.
    prop('flag', defaultsTo: true),
  ],
);

@GenerateEditSchema()
final boardTree = editTree<Board>(
  id: 'board',
  fields: [list('tasks', of: taskNode)],
);
