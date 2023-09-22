import 'package:flutter/material.dart';
import 'package:task_management_app/screens/task/task-screen.dart';
import 'package:task_management_app/view%20models/task%20view%20models/task_view_model.dart';
import 'package:task_management_app/widgets/bottom_navigation_bar.dart';

void openHome(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
}

void openTask(BuildContext context, TaskViewModel taskModel) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => TaskScreen(taskModel: taskModel)));
}
