import 'package:flutter/material.dart';
import 'package:task_management_app/models/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskModel taskModel;

  TaskViewModel({required this.taskModel});

  int get key => taskModel.key;

  String get title => taskModel.title;

  String get description => taskModel.description;

  String get priority => taskModel.priority;

  DateTime get date => taskModel.date;

  bool get isDone => taskModel.isDone;
}
