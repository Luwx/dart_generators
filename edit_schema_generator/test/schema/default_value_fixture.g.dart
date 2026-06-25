// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_value_fixture.dart';

// **************************************************************************
// EditSchemaSourceGenerator
// **************************************************************************

// Generated code. Do not modify by hand.
// ignore_for_file: dead_code, prefer_null_aware_operators, lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, unnecessary_parenthesis, unreachable_switch_case, unused_element, invalid_null_aware_operator, unused_local_variable, avoid_equals_and_hash_code_on_mutable_classes, no_literal_bool_comparisons

Lens<Board, Board> _boardRootLens() => Lens<Board, Board>(
  get: (root) => root as Board,
  set: (root, next) => next,
  name: 'board',
);

enum BoardDirtyField { taskTitle, taskMode, taskFlag }

final class TaskLocation {
  const TaskLocation({required this.taskIndex});

  final int taskIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskLocation && other.taskIndex == taskIndex);

  @override
  int get hashCode => taskIndex.hashCode;
}

final _boardTasksPart = LensPart<Board, List<Task>>(
  get: (value) => value.tasks,
  set: (value, next) => value.copyWith(tasks: next),
  name: 'tasks',
);

LensPart<Board, Task> _boardTasksItemPart(int index) => LensPart<Board, Task>(
  get: (value) => value.tasks[index],
  set: (value, nextValue) {
    if (index < 0 || index >= value.tasks.length) return value;
    final next = List<Task>.of(value.tasks);
    next[index] = nextValue;
    return value.copyWith(tasks: next);
  },
  canGet: (value) => index >= 0 && index < value.tasks.length,
  name: 'tasks[$index]',
);

Board replaceTaskAt(Board root, int index, Task value) {
  final list = root.tasks;
  if (index < 0 || index >= list.length) return root;
  final next = List<Task>.of(list);
  next[index] = value;
  return root.copyWith(tasks: next);
}

Board updateTaskAt(Board root, int index, Task Function(Task value) update) {
  final list = root.tasks;
  if (index < 0 || index >= list.length) return root;
  final next = List<Task>.of(list);
  next[index] = update(next[index]);
  return root.copyWith(tasks: next);
}

Board insertTaskAt(Board root, int index, Task value) {
  final list = root.tasks;
  if (index < 0 || index > list.length) return root;
  final next = List<Task>.of(list)..insert(index, value);
  return root.copyWith(tasks: next);
}

Board addTask(Board root, Task value) {
  final next = List<Task>.of(root.tasks)..add(value);
  return root.copyWith(tasks: next);
}

Board removeTaskAt(Board root, int index) {
  final list = root.tasks;
  if (index < 0 || index >= list.length) return root;
  final next = List<Task>.of(list)..removeAt(index);
  return root.copyWith(tasks: next);
}

Board duplicateTaskAt(Board root, int index) {
  final list = root.tasks;
  if (index < 0 || index >= list.length) return root;
  final next = List<Task>.of(list)..insert(index + 1, list[index]);
  return root.copyWith(tasks: next);
}

Board moveTask(Board root, int from, int to) {
  final list = root.tasks;
  if (from < 0 || from >= list.length) return root;
  final next = List<Task>.of(list);
  final item = next.removeAt(from);
  next.insert(to.clamp(0, next.length), item);
  return root.copyWith(tasks: next);
}

final _boardTaskTitlePart = LensPart<Task, String>(
  get: (value) => value.title,
  set: (value, next) => value.copyWith(title: next),
  name: 'title',
);

final _boardTaskModePart = LensPart<Task, Mode>(
  get: (value) => value.mode ?? Mode.end,
  set: (value, next) => value.copyWith(mode: next == Mode.end ? null : next),
  name: 'mode',
);

final _boardTaskFlagPart = LensPart<Task, bool>(
  get: (value) => value.flag ?? true,
  set: (value, next) => value.copyWith(flag: next == true ? null : next),
  name: 'flag',
);

Lens<Board, List<Task>> tasksLens() => _boardRootLens().then(_boardTasksPart);

List<Task>? tasksAt(Board? root) {
  if (root == null) return null;
  final lens = tasksLens();
  try {
    if (!lens.canGet(root)) return null;
    return lens.get(root);
  } on Object catch (_) {
    return null;
  }
}

Lens<Board, Task> taskLens(TaskLocation location) =>
    _boardRootLens().then(_boardTasksItemPart(location.taskIndex));

Task? taskAt(Board? root, TaskLocation location) {
  if (root == null) return null;
  final lens = taskLens(location);
  try {
    if (!lens.canGet(root)) return null;
    return lens.get(root);
  } on Object catch (_) {
    return null;
  }
}

Lens<Board, String> taskTitleLens(TaskLocation location) => _boardRootLens()
    .then(_boardTasksItemPart(location.taskIndex))
    .then(_boardTaskTitlePart);

Lens<Board, Mode> taskModeLens(TaskLocation location) => _boardRootLens()
    .then(_boardTasksItemPart(location.taskIndex))
    .then(_boardTaskModePart);

Lens<Board, bool> taskFlagLens(TaskLocation location) => _boardRootLens()
    .then(_boardTasksItemPart(location.taskIndex))
    .then(_boardTaskFlagPart);

bool taskTitleHasSavedBacking(Board? saved, TaskLocation location) {
  if (saved == null) return false;
  try {
    taskTitleLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final taskTitleField =
    GeneratedEditField<Board, TaskLocation, String, Lens<Board, String>>(
      id: 'taskTitle',
      dirtyField: BoardDirtyField.taskTitle,
      lens: taskTitleLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool taskModeHasSavedBacking(Board? saved, TaskLocation location) {
  if (saved == null) return false;
  try {
    taskModeLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final taskModeField =
    GeneratedEditField<Board, TaskLocation, Mode, Lens<Board, Mode>>(
      id: 'taskMode',
      dirtyField: BoardDirtyField.taskMode,
      lens: taskModeLens,
      fallback: null,
      defaultValue: Mode.end,
      adapter: FieldAdapterSpec<Mode>.identity(),
    );

bool taskFlagHasSavedBacking(Board? saved, TaskLocation location) {
  if (saved == null) return false;
  try {
    taskFlagLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final taskFlagField =
    GeneratedEditField<Board, TaskLocation, bool, Lens<Board, bool>>(
      id: 'taskFlag',
      dirtyField: BoardDirtyField.taskFlag,
      lens: taskFlagLens,
      fallback: null,
      defaultValue: true,
      adapter: FieldAdapterSpec<bool>.identity(),
    );

Object? comparableBoardFieldValue(Board? value, BoardDirtyField field) =>
    switch (field) {
      BoardDirtyField.taskTitle => null,
      BoardDirtyField.taskMode => null,
      BoardDirtyField.taskFlag => null,
    };

Object? comparableTaskValue(Task? value) => [
  value?.title,
  value?.mode ?? Mode.end,
  value?.flag ?? true,
];

Object? comparableBoardValue(Board? value) => [
  (value?.tasks ?? const <Task>[]).map(comparableTaskValue).toList(),
];
