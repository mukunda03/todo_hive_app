import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive_app/models/task_model.dart';
import 'package:todo_hive_app/screens/task_view_screen.dart';
import 'package:todo_hive_app/services/hive_service.dart';
import 'package:todo_hive_app/widgets/delete_dialog.dart';
import 'package:todo_hive_app/widgets/empty_list_widget.dart';

class TaskList extends StatelessWidget {
  final String filter;
  const TaskList({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Task>('tasksBox').listenable(),
      builder: (context, Box<Task> box, _) {
        List<Task> tasks = box.values.toList();
        if (filter == 'pending')
          tasks = tasks.where((t) => !t.isCompleted).toList();
        else if (filter == 'completed')
          tasks = tasks.where((t) => t.isCompleted).toList();

        return tasks.isEmpty
            ? buildEmptyState(filter == "all" ? "" : filter)
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(
                          2,
                        ), // The border gradient trick
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: task.isCompleted
                                ? [Colors.transparent, Colors.transparent]
                                : [Colors.white10, Colors.transparent],
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF161618),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TaskViewScreen(task: task),
                              ),
                            ),

                            // Minimalist Dot Toggle
                            leading: IconButton(
                              icon: Icon(
                                task.isCompleted
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off,
                                color: task.isCompleted
                                    ? Colors.cyanAccent
                                    : Colors.white24,
                              ),
                              onPressed: () {
                                task.isCompleted = !task.isCompleted;
                                HiveService.updateTask(task);
                              },
                            ),

                            title: Text(
                              task.title
                                  .toLowerCase(), // Minimalist lowercase look
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: -0.5,
                                color: task.isCompleted
                                    ? Colors.white70
                                    : Colors.white,
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            subtitle: Text(
                              task.description,
                              style: const TextStyle(
                                color: Colors.white30,
                                fontSize: 13,
                              ),
                            ),

                            trailing: !task.isCompleted
                                ? Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: Colors.white60,
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () =>
                                        CustomDialog.showDeleteDialog(
                                          context,
                                          task,
                                          false,
                                        ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
