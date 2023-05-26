import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      name: 'Terminar projeto da pós',
      date: DateTime.now(),
      location: '122333',
    ),
    Task(
      name: 'Concluir capítulo 9 do curso',
      date: DateTime.now(),
      location: '454545',
    ),
  ];

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

  Task showTask(int index) {
    return _tasks[index];
  }
}
