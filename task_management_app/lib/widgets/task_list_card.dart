import 'package:flutter/material.dart';
import 'package:task_management_app/utils/constraints.dart';
import 'package:task_management_app/utils/navigation.dart';
import 'package:task_management_app/view%20models/task%20view%20models/task_view_model.dart';

class TaskListCard extends StatefulWidget {
  final List<TaskViewModel> tasks;

  final DateTime? selectedDay;
  const TaskListCard({Key? key, this.selectedDay, required this.tasks})
      : super(key: key);

  @override
  State<TaskListCard> createState() => _TaskListCardState();
}

class _TaskListCardState extends State<TaskListCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          final task = widget.tasks[index];

          return InkWell(
            onTap: () {
              openTask(context, task);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index != 0 &&
                    Convert.getDate(date: task.date) ==
                        Convert.getDate(date: widget.tasks[index - 1].date))
                  ...[]
                else ...[
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                            vertical: size.height * 0.01),
                        child: SizedBox(
                          width: size.width * 0.4,
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  Convert.getDate(date: task.date),
                                ),
                                flex: 1,
                              ),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Icon(Icons.keyboard_arrow_down_outlined)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
                Card(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.05),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Convert.upperCase(text: task.title),
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              SizedBox(
                                width: size.width * 0.35,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      Convert.getDate(date: task.date),
                                      style: TextStyle(
                                          color: Color(0xFFAFAFAF),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: task.isDone == true
                                        ? Colors.green
                                        : kPrimaryErrorColor,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    task.isDone == true
                                        ? "Completed"
                                        : "Not Complete",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: task.isDone == true
                                            ? Colors.green
                                            : kPrimaryErrorColor),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.black, width: 1)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.flag_outlined,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.01,
                                            ),
                                            Text(
                                              task.priority.toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )),
              ],
            ),
          );
        });
  }
}
