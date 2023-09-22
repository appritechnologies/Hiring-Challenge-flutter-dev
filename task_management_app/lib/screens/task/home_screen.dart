import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/widgets/task_list_card.dart';

import 'package:task_management_app/utils/constraints.dart';
import 'package:task_management_app/view%20models/task%20view%20models/task_list_view_model.dart';

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
    Provider.of<TaskListViewModel>(context, listen: false)
        .getAllTasks(isDone: false);
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TaskListViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03),
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
