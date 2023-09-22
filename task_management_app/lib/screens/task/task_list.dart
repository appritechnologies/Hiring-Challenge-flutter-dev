import 'package:flutter/material.dart';
import 'package:task_management_app/utils/constraints.dart';
import 'package:task_management_app/widgets/tab%20views/complete_tasks.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "All Tasks",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorPadding:
                EdgeInsets.symmetric(horizontal: size.width * 0.01),
            tabs: [
              Tab(
                text: "To Do",
              ),
              Tab(
                text: "Done",
              ),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicatorColor: kPrimaryButtonColor,
            indicator: BoxDecoration(
                color: kPrimaryButtonColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
        body: TabBarView(
          children: [
            CompleteTasks(
              isDone: false,
            ),
            CompleteTasks(
              isDone: true,
            ),
          ],
        ),
      ),
    );
  }
}
