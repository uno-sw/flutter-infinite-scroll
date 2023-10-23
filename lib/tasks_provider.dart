import 'package:infinite_scroll/task_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'task.dart';

part 'tasks_provider.g.dart';

@riverpod
Future<List<Task>> tasksPage(
  TasksPageRef ref, {
  Task? lastTask,
  required TaskOrder order,
}) {
  return ref
      .watch(taskRepositoryProvider)
      .fetchPage(lastTask: lastTask, order: order);
}
