import 'package:flutter/foundation.dart';

@immutable
class Task {
  const Task({
    required this.id,
    required this.name,
    required this.completed,
  });

  final String id;
  final String name;
  final bool completed;
}
