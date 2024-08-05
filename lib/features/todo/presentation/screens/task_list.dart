import 'package:flutter/material.dart';
import 'package:job_assingment/features/todo/presentation/screens/task_tile.dart';

import '../../domain/entities/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskTile(task: task, index: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 5,
          color: Colors.black45,
        );
      },
    );
  }
}
