import 'package:flutter/cupertino.dart';

import 'package:task_management_app/services/hive%20handler/hive.dart';

import 'package:task_management_app/view%20models/task%20view%20models/task_view_model.dart';

enum Status { loading, empty, success }

class TaskListViewModel extends ChangeNotifier {
  List<TaskViewModel> tasks = <TaskViewModel>[];
  List<TaskViewModel> compleTasks = <TaskViewModel>[];
  Status status = Status.empty;

  Future<void> getAllTasks({required bool isDone}) async {
    status = Status.loading;
    final results = await HiveHandler.getAllTasks();
    tasks = results.map((task) => TaskViewModel(taskModel: task)).toList();
    if (isDone == false) {
      tasks = tasks.where((task) => task.isDone == false).toList();
    } else {
      tasks = tasks.where((task) => task.isDone == true).toList();
    }
    tasks.sort((a, b) => b.date.compareTo(a.date));
    status = tasks.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }
}
