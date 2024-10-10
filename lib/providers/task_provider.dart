import 'package:flutter/material.dart';
import 'package:t2_2022130040/models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = []; //atribut state
  List<Task> get tasks => _tasks; //deklarasi getter

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void editTask(Task task) {
    final index = _tasks.indexWhere((element) => element.id == task.id);
    _tasks[index] = task;
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void clearTasks() {
    _tasks.clear();
    notifyListeners();
  }
}
