import 'package:flutter/cupertino.dart';

import 'package:task_management_app/services/hive%20handler/hive.dart';

import 'package:task_management_app/view%20models/task%20view%20models/task_view_model.dart';

enum Status { loading, empty, success }

class TaskListViewModel extends ChangeNotifier {
  List<TaskViewModel> tasks = <TaskViewModel>[];
  Status status = Status.empty;

  Future<void> getAllTasks() async {
    status = Status.loading;
    final results = await HiveHandler.getAllTasks();

    tasks = results.map((task) => TaskViewModel(taskModel: task)).toList();
    status = tasks.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }
}
