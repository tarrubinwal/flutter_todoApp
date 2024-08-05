import 'package:hive/hive.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class HiveTaskRepository implements TaskRepository {
  static const _boxName = 'tasks';

  @override
  Future<List<Task>> getAllTasks() async {
    final box = await Hive.openBox<Task>(_boxName);
    return box.values.toList();
  }

  @override
  Future<void> addTask(Task task) async {
    final box = await Hive.openBox<Task>(_boxName);
    await box.add(task);
  }

  @override
  Future<void> toggleTask(int index) async {
    final box = await Hive.openBox<Task>(_boxName);
    final task = box.getAt(index);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      await task.save();
    }
  }
}
