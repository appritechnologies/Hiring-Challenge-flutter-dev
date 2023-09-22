import 'package:flutter/material.dart';

import 'package:task_management_app/models/boxes.dart';
import 'package:task_management_app/models/task_model.dart';


class AddTaskViewModel extends ChangeNotifier {
  late String title;
  late String description;
  late String priority;
  late DateTime date;
  late bool isDone;

  Future addTodo() async {
    final task = TaskModel()
      ..title = title
      ..description = description
      ..date = date
      ..priority = priority
      ..isDone = isDone;
    final box = Boxes.getTasks();
    box.add(task);
    notifyListeners();
  }

  Future<void> updateTodo({required int id}) async {
    final task = TaskModel()
      ..title = title
      ..description = description
      ..date = date
      ..priority = priority
      ..isDone = isDone;
    final box = Boxes.getTasks();
    box.put(id, task);
    notifyListeners();
  }

  Future<void> deleteTodo({required int id}) async {
    final box = Boxes.getTasks();
    box.delete(id);
    notifyListeners();
  }
}
