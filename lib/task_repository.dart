import 'task.dart';

class TaskRepository {
  final List<Task> _tasks = List.generate(
    100,
    (index) => Task(
      id: '${index + 1}',
      name: 'Task ${index + 1}',
      completed: false,
    ),
  );

  Future<List<Task>> fetchPage({
    int limit = 20,
    Task? lastTask,
    TaskOrder order = TaskOrder.asc,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    var tasks = switch (order) {
      TaskOrder.asc => _tasks,
      TaskOrder.desc => _tasks.reversed,
    };
    if (lastTask != null) {
      tasks = tasks.skipWhile((task) => task.id != lastTask.id).skip(1);
    }
    return tasks.take(limit).toList();
  }
}

enum TaskOrder { asc, desc }
