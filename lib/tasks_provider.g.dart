// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasksPageHash() => r'd7326359516f10f1e7dee5b5256b3e93d15e1213';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [tasksPage].
@ProviderFor(tasksPage)
const tasksPageProvider = TasksPageFamily();

/// See also [tasksPage].
class TasksPageFamily extends Family<AsyncValue<List<Task>>> {
  /// See also [tasksPage].
  const TasksPageFamily();

  /// See also [tasksPage].
  TasksPageProvider call({
    Task? lastTask,
    required TaskOrder order,
  }) {
    return TasksPageProvider(
      lastTask: lastTask,
      order: order,
    );
  }

  @override
  TasksPageProvider getProviderOverride(
    covariant TasksPageProvider provider,
  ) {
    return call(
      lastTask: provider.lastTask,
      order: provider.order,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tasksPageProvider';
}

/// See also [tasksPage].
class TasksPageProvider extends AutoDisposeFutureProvider<List<Task>> {
  /// See also [tasksPage].
  TasksPageProvider({
    Task? lastTask,
    required TaskOrder order,
  }) : this._internal(
          (ref) => tasksPage(
            ref as TasksPageRef,
            lastTask: lastTask,
            order: order,
          ),
          from: tasksPageProvider,
          name: r'tasksPageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tasksPageHash,
          dependencies: TasksPageFamily._dependencies,
          allTransitiveDependencies: TasksPageFamily._allTransitiveDependencies,
          lastTask: lastTask,
          order: order,
        );

  TasksPageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lastTask,
    required this.order,
  }) : super.internal();

  final Task? lastTask;
  final TaskOrder order;

  @override
  Override overrideWith(
    FutureOr<List<Task>> Function(TasksPageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TasksPageProvider._internal(
        (ref) => create(ref as TasksPageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lastTask: lastTask,
        order: order,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Task>> createElement() {
    return _TasksPageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TasksPageProvider &&
        other.lastTask == lastTask &&
        other.order == order;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lastTask.hashCode);
    hash = _SystemHash.combine(hash, order.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TasksPageRef on AutoDisposeFutureProviderRef<List<Task>> {
  /// The parameter `lastTask` of this provider.
  Task? get lastTask;

  /// The parameter `order` of this provider.
  TaskOrder get order;
}

class _TasksPageProviderElement
    extends AutoDisposeFutureProviderElement<List<Task>> with TasksPageRef {
  _TasksPageProviderElement(super.provider);

  @override
  Task? get lastTask => (origin as TasksPageProvider).lastTask;
  @override
  TaskOrder get order => (origin as TasksPageProvider).order;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
