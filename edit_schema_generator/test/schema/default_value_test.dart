import 'package:edit_schema_generator/edit_schema_generator.dart';
import 'package:test/test.dart';

import 'default_value_fixture.dart';
import 'default_value_test_models.dart';

void main() {
  group('prop defaultsTo', () {
    const board = Board(tasks: [Task(title: 'a')]);
    const location = TaskLocation(taskIndex: 0);

    test('lens type is non-nullable and reads the default when absent', () {
      final Lens<Board, Mode> lens = taskModeLens(location);
      expect(lens.get(board), Mode.end);
    });

    test('writing a non-default value stores it through', () {
      final Lens<Board, Mode> lens = taskModeLens(location);
      final updated = lens.set(board, Mode.begin);
      expect(lens.get(updated), Mode.begin);
      expect(updated.tasks.first.mode, Mode.begin);
    });

    test('writing the default compacts the property back to null', () {
      final Lens<Board, Mode> lens = taskModeLens(location);
      final set = lens.set(board, Mode.begin);
      final cleared = lens.set(set, Mode.end);
      expect(cleared.tasks.first.mode, isNull);
      expect(lens.get(cleared), Mode.end);
    });

    test('bool default collapses and compacts the same way', () {
      final Lens<Board, bool> lens = taskFlagLens(location);
      expect(lens.get(board), isTrue);
      final off = lens.set(board, false);
      expect(off.tasks.first.flag, isFalse);
      final back = lens.set(off, true);
      expect(back.tasks.first.flag, isNull);
      expect(lens.get(back), isTrue);
    });

    test('the generated field ref exposes the schema default', () {
      expect(taskModeField.defaultValue, Mode.end);
      expect(taskFlagField.defaultValue, isTrue);
      expect(taskTitleField.defaultValue, isNull);
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
