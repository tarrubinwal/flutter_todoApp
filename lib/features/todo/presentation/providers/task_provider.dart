import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_assingment/features/todo/data/respositories/hive_task_repository.dart';
import 'package:job_assingment/features/todo/domain/entities/task.dart';
import 'package:job_assingment/features/todo/domain/repositories/task_repository.dart';


final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return HiveTaskRepository();
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier(this._taskRepository) : super([]);

  final TaskRepository _taskRepository;

  Future<void> loadTasks() async {
    state = await _taskRepository.getAllTasks();
  }

  Future<void> addTask(String title) async {
    final task = Task(title: title);
    await _taskRepository.addTask(task);
    state = await _taskRepository.getAllTasks();
  }

  Future<void> toggleTask(int index) async {
    await _taskRepository.toggleTask(index);
    state = await _taskRepository.getAllTasks();
  }

  List<Task> get completedTasks {
    return state.where((task) => task.isCompleted).toList();
  }

  List<Task> get uncompletedTasks {
    return state.where((task) => !task.isCompleted).toList();
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(taskRepository);
});
