import 'package:test/test.dart';

import 'default_value_fixture.dart';
import 'default_value_test_models.dart';
import 'test_lens.dart';

void main() {
  group('prop defaultsTo', () {
    const board = Board(tasks: [Task(title: 'a')]);
    const location = TaskLocation(taskIndex: 0);

    test('lens type is non-nullable and reads the default when absent', () {
      final Lens<Mode> lens = taskModeLens(location);
      expect(lens.get(board), Mode.end);
    });

    test('writing a non-default value stores it through', () {
      final Lens<Mode> lens = taskModeLens(location);
      final updated = lens.set(board, Mode.begin) as Board;
      expect(lens.get(updated), Mode.begin);
      expect(updated.tasks.first.mode, Mode.begin);
    });

    test('writing the default compacts the property back to null', () {
      final Lens<Mode> lens = taskModeLens(location);
      final set = lens.set(board, Mode.begin) as Board;
      final cleared = lens.set(set, Mode.end) as Board;
      expect(cleared.tasks.first.mode, isNull);
      expect(lens.get(cleared), Mode.end);
    });

    test('comparable treats absent and explicit default as equal', () {
      expect(
        comparableTaskValue(const Task(title: 'a')),
        comparableTaskValue(const Task(title: 'a', mode: Mode.end)),
      );
      expect(
        comparableTaskValue(const Task(title: 'a', mode: Mode.begin)),
        isNot(comparableTaskValue(const Task(title: 'a'))),
      );
    });
  });
}
