import 'package:flutter/material.dart';

import 'task.dart';
import 'task_repository.dart';

class TaskIndexScreen extends StatefulWidget {
  const TaskIndexScreen({super.key, required this.repository});

  final TaskRepository repository;

  @override
  State<TaskIndexScreen> createState() => _TaskIndexScreenState();
}

class _TaskIndexScreenState extends State<TaskIndexScreen> {
  final _tasks = <Task>[];

  TaskOrder _order = TaskOrder.asc;
  bool _isLoading = false;
  bool _hasMore = true;

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) {
      return;
    }

    _isLoading = true;

    final lastTask = _tasks.lastOrNull;
    final tasks = await widget.repository.fetchPage(
      lastTask: lastTask,
      order: _order,
    );

    _isLoading = false;
    setState(() {
      _tasks.addAll(tasks);
      _hasMore = tasks.isNotEmpty;
    });
  }

  Future<void> _refresh() async {
    _isLoading = false;
    setState(() {
      _tasks.clear();
      _hasMore = true;
    });
    await _loadMore();
  }

  @override
  void initState() {
    super.initState();
    _loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          TaskSortButton(
            value: _order,
            onChanged: (order) {
              setState(() {
                _order = order;
              });
              _refresh();
            },
          ),
        ],
      ),
      body: TaskListView(
        tasks: _tasks,
        onScrollToEnd: _loadMore,
        hasMore: _hasMore,
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
