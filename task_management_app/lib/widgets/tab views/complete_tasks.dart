import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/view%20models/task%20view%20models/task_list_view_model.dart';
import 'package:task_management_app/widgets/task_list_card.dart';
import 'package:task_management_app/utils/constraints.dart';
import 'package:lottie/lottie.dart';

class CompleteTasks extends StatefulWidget {
  final bool isDone;
  const CompleteTasks({super.key, required this.isDone});

  @override
  State<CompleteTasks> createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TaskListViewModel>(context, listen: false)
        .getAllTasks(isDone: widget.isDone);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TaskListViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
            ],
          ),
          Expanded(child: _updateUi(vm)),
          SizedBox(
            height: size.height * 0.1,
          )
        ],
      ),
    );
  }

  Widget _updateUi(TaskListViewModel vm) {
    switch (vm.status) {
      case Status.loading:
        return Align(
          alignment: Alignment.center,
          child: Lottie.asset(loadingAnim, width: 200, height: 200),
        );
      case Status.success:
        return TaskListCard(tasks: vm.tasks);
      case Status.empty:
        return Align(
          alignment: Alignment.center,
          child: Lottie.asset(todoAnim, width: 300, height: 300),
        );
    }
  }
}
