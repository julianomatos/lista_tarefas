import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      name: 'Terminar projeto da pós',
      date: DateTime(2023, 05, 29, 17, 00),
      location: '122333',
    ),
    Task(
      name: 'Concluir capítulo 9 do curso',
      date: DateTime(2023, 05, 27, 20, 00),
      location: '454545',
    ),Task(
      name: 'Compras no mercado',
      date: DateTime(2023, 05, 26, 11, 20),
      location: '334455',
    ),
    Task(
      name: 'Ir ao dentista',
      date: DateTime(2023, 05, 24, 8, 30),
      location: '667788',
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
