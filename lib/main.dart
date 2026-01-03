import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive_app/screens/home_screen.dart';
import 'models/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Registering the Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  // Open task box
  await Hive.openBox<Task>('tasksBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tsk.',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
