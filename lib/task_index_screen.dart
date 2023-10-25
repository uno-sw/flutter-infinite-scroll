// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'task.dart';
import 'tasks_provider.dart';
import 'task_repository.dart';

typedef UseTasksResult = ({
  List<Task> tasks,
  VoidCallback loadMore,
  bool hasMore,
});

UseTasksResult useTasks({required WidgetRef ref, required TaskOrder order}) {
  final currentPage = useState(1);

  useEffect(() {
    currentPage.value = 1;
  }, [order]);

  final pages = <List<Task>>[];
  var hasMore = true;

  for (var i = 0; i < currentPage.value; i++) {
    final lastPage = pages.lastOrNull;
    final page = ref
        .watch(tasksPageProvider(lastTask: lastPage?.lastOrNull, order: order));
    if (page case AsyncValue(:final value?)) {
      if (value.isNotEmpty) {
        pages.add(value);
      } else {
        hasMore = false;
        break;
      }
    } else {
      break;
    }
  }

  final loadMore = useCallback(() {
    if (currentPage.value == pages.length && hasMore) {
      currentPage.value++;
    }
  }, [currentPage.value, pages.length, hasMore]);

  return (
    tasks: pages.expand((page) => page).toList(),
    loadMore: loadMore,
    hasMore: hasMore,
  );
}

class TaskIndexScreen extends HookConsumerWidget {
  const TaskIndexScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = useState(TaskOrder.asc);
    final (
      :tasks,
      :loadMore,
      :hasMore,
    ) = useTasks(ref: ref, order: order.value);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          TaskSortButton(
            value: order.value,
            onChanged: (value) => order.value = value,
          ),
        ],
      ),
      body: TaskListView(
        tasks: tasks,
        onScrollToEnd: loadMore,
        hasMore: hasMore,
      ),
    );
  }
}

class TaskSortButton extends StatelessWidget {
  const TaskSortButton({
    super.key,
    required this.value,
    this.onChanged,
  });

  final TaskOrder value;
  final ValueChanged<TaskOrder>? onChanged;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        for (final order in TaskOrder.values)
          MenuItemButton(
            onPressed: () {
              if (order != value) {
                onChanged?.call(order);
              }
            },
            leadingIcon: Icon(
              order == value ? Icons.check : null,
            ),
            child: switch (order) {
              TaskOrder.asc => const Text('Ascending'),
              TaskOrder.desc => const Text('Descending'),
            },
          ),
      ],
      builder: (context, controller, child) => IconButton(
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        icon: const Icon(Icons.sort),
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  const TaskListView({
    super.key,
    required this.tasks,
    this.onScrollToEnd,
    this.hasMore = true,
  });

  final List<Task> tasks;
  final VoidCallback? onScrollToEnd;
  final bool hasMore;

  static const _progressIndicatorExtent = 56.0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < _progressIndicatorExtent) {
          onScrollToEnd?.call();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: tasks.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == tasks.length) {
            return const SizedBox.square(
              dimension: _progressIndicatorExtent,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: FittedBox(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else {
            return ListTile(
              title: Text(tasks[index].name),
            );
          }
        },
      ),
    );
  }
}
