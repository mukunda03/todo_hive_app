import 'package:flutter/material.dart';
import 'package:todo_hive_app/screens/edit_task_screen.dart';
import 'package:todo_hive_app/widgets/delete_dialog.dart';
import '../models/task_model.dart';
import '../services/hive_service.dart';

class TaskViewScreen extends StatefulWidget {
  final Task task;

  const TaskViewScreen({super.key, required this.task});

  @override
  State<TaskViewScreen> createState() => _TaskViewScreenState();
}

class _TaskViewScreenState extends State<TaskViewScreen> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.task.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B), // Deep Obsidian
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Edit Action with a subtle background
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.edit_note, color: Colors.cyanAccent),
              onPressed: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditTaskScreen(task: widget.task),
                  ),
                );
                if (updated == true) setState(() {});
              },
            ),
          ),
          const SizedBox(width: 8),
          // Delete Action
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: () {
              CustomDialog.showDeleteDialog(context, widget.task, true);
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Status Badge ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isCompleted
                    ? Colors.greenAccent.withOpacity(0.1)
                    : Colors.orangeAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isCompleted
                      ? Colors.greenAccent.withOpacity(0.3)
                      : Colors.orangeAccent.withOpacity(0.3),
                ),
              ),
              child: Text(
                isCompleted ? "COMPLETED" : "IN PROGRESS",
                style: TextStyle(
                  color: isCompleted ? Colors.greenAccent : Colors.orangeAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Task Title ---
            Text(
              widget.task.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionLabel("MISSION DETAILS"),
            const SizedBox(height: 12),

            // --- Description Glass Box ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Text(
                widget.task.description.isEmpty
                    ? 'No additional specifications provided.'
                    : widget.task.description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // --- Interactive Completion Toggle ---
            _buildSectionLabel("STATUS CONTROL"),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Text(
                    'Mark as Finished',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: isCompleted,
                    activeTrackColor: Colors.cyanAccent.withOpacity(0.3),
                    activeColor: Colors.cyanAccent,
                    inactiveThumbColor: Colors.white24,
                    inactiveTrackColor: Colors.white12,
                    onChanged: (value) {
                      setState(() => isCompleted = value);
                      widget.task.isCompleted = value;
                      HiveService.updateTask(widget.task);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withOpacity(0.3),
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
      ),
    );
  }
}
