import 'models/task.dart';

class TaskManager {
  List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
  }

  void editTask(int index, Task task) {
    tasks[index] = task;
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
  }
}
