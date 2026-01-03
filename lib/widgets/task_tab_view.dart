import 'package:flutter/material.dart';
import 'package:todo_hive_app/widgets/task_list_screen.dart';

class TaskTabView extends StatelessWidget {
  const TaskTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        TaskList(filter: 'all'),
        TaskList(filter: 'pending'),
        TaskList(filter: 'completed'),
      ],
    );
  }
}
