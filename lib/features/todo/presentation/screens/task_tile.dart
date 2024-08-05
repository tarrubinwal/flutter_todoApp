import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_assingment/features/todo/domain/entities/task.dart';
import 'package:job_assingment/features/todo/presentation/providers/task_provider.dart';
class TaskTile extends ConsumerWidget {
  final Task task;
  final int index;

  const TaskTile({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.circle,
          color: task.isCompleted ? Colors.green : Colors.grey,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          task.isCompleted ? 'Completed' : 'Pending',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: task.isCompleted ? Colors.green : Colors.red,
          ),
        ),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (_) {
            ref.read(taskProvider.notifier).toggleTask(index);
          },
        ),
      ),
    );
  }
}
