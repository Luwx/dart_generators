// Models for the `defaultsTo` collapse fixture. `Task.mode` is a nullable enum
// whose absent state means a daemon-style default (`Mode.end`), mirroring the
// app's `TriggerAction.on`. `copyWith` uses a sentinel so the default can be
// compacted back to null.

enum Mode { begin, middle, end }

const Object _unset = Object();

final class Task {
  const Task({required this.title, this.mode});

  final String title;
  final Mode? mode;

  Task copyWith({String? title, Object? mode = _unset}) => Task(
    title: title ?? this.title,
    mode: mode == _unset ? this.mode : mode as Mode?,
  );
}

final class Board {
  const Board({this.tasks = const []});

  final List<Task> tasks;

  Board copyWith({List<Task>? tasks}) => Board(tasks: tasks ?? this.tasks);
}
