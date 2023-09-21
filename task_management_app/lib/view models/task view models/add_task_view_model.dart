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

  // Future<void> updateTodo() async {
  //   final taskModel = TaskModel(
  //     id: id,
  //     title: title,
  //     description: description,
  //     priority: priority,
  //     date: date,
  //     isDone: isDone,
  //   );
  //   await _myBox.put(id, taskModel.toMap());
  //   notifyListeners();
  // }
}
