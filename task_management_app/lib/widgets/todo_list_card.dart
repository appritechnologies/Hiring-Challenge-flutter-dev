import 'package:flutter/material.dart';
import 'package:task_management_app/utils/constraints.dart';
import 'package:task_management_app/view%20models/task%20view%20models/task_view_model.dart';

class TodoListCard extends StatefulWidget {
  final List<TaskViewModel> tasks;
  final Function(String) function;
  final DateTime? selectedDay;
  TodoListCard(
      {Key? key, required this.function, this.selectedDay, required this.tasks})
      : super(key: key);

  @override
  State<TodoListCard> createState() => _TodoListCardState();
}

class _TodoListCardState extends State<TodoListCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          final task = widget.tasks[index];

          return InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index != 0 &&
                    Convert.getDate(date: task.date) ==
                        Convert.getDate(date: widget.tasks[index - 1].date))
                  ...[]
                else ...[
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
                      child: SizedBox(
                        width: screenWidth * 0.4,
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                Convert.getDate(date: task.date),
                              ),
                              flex: 1,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.keyboard_arrow_down_outlined)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
                Card(
                    child: Padding(
                  padding: EdgeInsets.all(15.0),
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
                                height: 10,
                              ),
                              SizedBox(
                                width: screenWidth * 0.35,
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
                                        fontSize: 10,
                                        color: task.isDone == true
                                            ? Colors.green
                                            : kPrimaryErrorColor),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.flag_outlined),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(task.priority.toString())
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
