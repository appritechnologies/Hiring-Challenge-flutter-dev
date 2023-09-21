import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:task_management_app/utils/constraints.dart';
import 'package:task_management_app/view%20models/task%20view%20models/task_list_view_model.dart';

import '../../widgets/todo_list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<TaskListViewModel>(context, listen: false).getAllTasks();
    // The rest of your initialization code
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TaskListViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Home",
          style: TextStyle(color: kPrimaryButtonColor),
        ),
      ),
      body: Padding(
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
              height: screenHeight * 0.1,
            )
          ],
        ),
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
        return TodoListCard(
            function: (taskId) async {
              print(taskId);
            },
            tasks: vm.tasks);
      case Status.empty:
        return Align(
          alignment: Alignment.center,
          child: Lottie.asset(todoAnim, width: 300, height: 300),
        );
    }
  }
}
