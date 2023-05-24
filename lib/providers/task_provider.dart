import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskManager with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void editTask(int index, Task task) {
    _tasks[index] = task;
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
