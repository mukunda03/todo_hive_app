import 'package:flutter/material.dart';
import 'package:todo_hive_app/screens/add_task_screen.dart';
import 'package:todo_hive_app/widgets/task_tab_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0B), // Deep Obsidian
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Custom Header ---
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tsk.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.blur_on,
                        color: Colors.cyanAccent,
                      ),
                    ),
                  ],
                ),
              ),

              // --- Neon Pill TabBar ---
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.cyanAccent.withOpacity(0.1),
                  ),
                  labelColor: Colors.cyanAccent,
                  unselectedLabelColor: Colors.white38,
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Pending'),
                    Tab(text: 'Completed'),
                  ],
                ),
              ),

              const Expanded(child: TaskTabView()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.large(
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          ),
          child: const Icon(Icons.add, color: Colors.black, size: 36),
        ),
      ),
    );
  }
}
