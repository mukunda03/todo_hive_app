import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/hive_service.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descController = TextEditingController(text: widget.task.description);
  }

  void _updateTask() {
    if (_titleController.text.isEmpty) return;

    widget.task.title = _titleController.text;
    widget.task.description = _descController.text;

    HiveService.updateTask(widget.task);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B), // Deep Obsidian
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'REFINE FLOW',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 14,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            _buildLabel("CURRENT OBJECTIVE"),
            const SizedBox(height: 12),
            _buildCustomField(
              controller: _titleController,
              hint: "Title",
              fontSize: 22,
              fontWeight: FontWeight.bold,
              accentColor: Colors.blueAccent,
            ),
            const SizedBox(height: 32),
            _buildLabel("SPECIFICATIONS"),
            const SizedBox(height: 12),
            _buildCustomField(
              controller: _descController,
              hint: "Details",
              fontSize: 16,
              maxLines: 6,
              accentColor: Colors.blueAccent,
            ),
            const Spacer(),
            // --- Tech-Style Update Button ---
            GestureDetector(
              onTap: _updateTask,
              child: Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blueAccent.withOpacity(0.5)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'SYNC CHANGES',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Aesthetic Reusable Components ---

  Widget _buildLabel(String text) {
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

  Widget _buildCustomField({
    required TextEditingController controller,
    required String hint,
    required double fontSize,
    required Color accentColor,
    FontWeight fontWeight = FontWeight.normal,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: accentColor,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: -0.5,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.1)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
