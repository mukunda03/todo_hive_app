import 'package:hive/hive.dart';
import 'package:todo_hive_app/models/task_model.dart';

class HiveService {
  static final Box<Task> _taskBox = Hive.box<Task>('tasksBox');

  // Get all task
  static List<Task> getTasks() {
    return _taskBox.values.toList();
  }

  // add task
  static Future<void> addTask(Task task) async {
    await _taskBox.add(task);
  }

  //Update Task(mark Cmplt / Edit)
  static Future<void> updateTask(Task task) async {
    await task.save();
  }

  //delete Task
  static Future<void> deleteTask(Task task) async {
    await task.delete();
  }
}
