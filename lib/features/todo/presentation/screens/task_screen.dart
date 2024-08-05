import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_assingment/features/todo/presentation/providers/task_provider.dart';
import 'package:job_assingment/features/todo/presentation/screens/task_list.dart';

class TaskScreen extends ConsumerStatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(taskProvider.notifier).loadTasks());
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);
    final completedTasks = ref.watch(taskProvider.notifier).completedTasks;
    final uncompletedTasks = ref.watch(taskProvider.notifier).uncompletedTasks;

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        bottom: TabBar(
          controller: _tabController,

          tabs:const  [
            Tab(text: 'All Tasks'),
            Tab(text: 'Completed Tasks'),
            Tab(text: 'Pending Tasks'),

          ],
          labelStyle: const  TextStyle(fontSize: 12),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                TaskList(tasks: tasks),
                TaskList(tasks: completedTasks),
                TaskList(tasks: uncompletedTasks),
              ],

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Enter task title'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      ref.read(taskProvider.notifier).addTask(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
