import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/utils/navigation.dart';
import 'package:task_management_app/utils/constraints.dart';
import 'package:task_management_app/view%20models/task%20view%20models/add_task_view_model.dart';
import 'package:task_management_app/view%20models/task%20view%20models/task_list_view_model.dart';
import 'package:task_management_app/view%20models/task%20view%20models/task_view_model.dart';
import 'package:task_management_app/widgets/button_field.dart';
import 'package:task_management_app/widgets/task_button.dart';
import 'package:task_management_app/widgets/edit_task_dialog.dart';
import 'package:task_management_app/widgets/edit_priority.dart';

import 'package:task_management_app/widgets/task_delete_dialog.dart';

class TaskScreen extends StatefulWidget {
  final TaskViewModel taskModel;
  const TaskScreen({Key? key, required this.taskModel}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late AddTaskViewModel addTaskViewModel;
  late TaskListViewModel taskListViewModel;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late DateTime _selectedDate;
  bool isDone = false;
  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskModel.title;
    descriptionController.text = widget.taskModel.description;
    _selectedDate = widget.taskModel.date;

    _populateTaskList();
  }

  _populateTaskList() {
    addTaskViewModel = Provider.of<AddTaskViewModel>(context, listen: false);
    addTaskViewModel.priority = widget.taskModel.priority;
    addTaskViewModel.title = widget.taskModel.title;
    addTaskViewModel.description = widget.taskModel.description;
    addTaskViewModel.isDone = widget.taskModel.isDone;
    isDone = widget.taskModel.isDone;
    taskListViewModel = Provider.of<TaskListViewModel>(context, listen: false);
  }

  List<String> toggleButtonOptions = ['LOW', 'MEDIUAM', 'HIGH'];
  List<bool> isSelectedOptions = [true, false, false];
  String? priority;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final task = widget.taskModel;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
            vertical: size.height * 0.01,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Convert.upperCase(text: addTaskViewModel.title),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                Convert.upperCase(
                                    text: addTaskViewModel.description),
                                style: TextStyle(
                                    color: kPrimaryTextColor, fontSize: 15),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return EditTaskDialog(
                                        titleController: titleController,
                                        descriptionController:
                                            descriptionController,
                                        onSave: (newTitle, newDescription) {
                                          setState(() {
                                            addTaskViewModel.title = newTitle;
                                            addTaskViewModel.description =
                                                newDescription;
                                          });
                                        },
                                      );
                                    });
                              },
                              icon: Icon(Icons.create_outlined))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TaskRow(
                      function: () {
                        _getCalendar(task.date);
                      },
                      text: Convert.getDate(date: _selectedDate),
                      topicIcon: Icons.calendar_month_outlined,
                      topic: "Task Date"),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TaskRow(
                      function: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditPriority(
                                onSave: () {},
                                onSelect: (index) {
                                  setState(() {
                                    for (int buttonIndex = 0;
                                        buttonIndex < isSelectedOptions.length;
                                        buttonIndex++) {
                                      isSelectedOptions[buttonIndex] =
                                          (buttonIndex == index);
                                    }
                                    priority = toggleButtonOptions[index];
                                    print(priority);
                                    addTaskViewModel.priority =
                                        priority.toString();
                                  });
                                },
                                priority: addTaskViewModel.priority,
                                isSelectedOptions: isSelectedOptions,
                                toggleButtonOptions: toggleButtonOptions,
                              );
                            });
                      },
                      text: addTaskViewModel.priority.toString(),
                      btnIcon: Icons.flag_outlined,
                      topicIcon: Icons.flag_outlined,
                      topic: "Task Priority"),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TaskRow(
                      function: () {
                        setState(() {
                          if (addTaskViewModel.isDone == false) {
                            isDone = true;
                            addTaskViewModel.isDone = true;
                          } else {
                            isDone = false;
                            addTaskViewModel.isDone = false;
                          }
                        });
                      },
                      text: addTaskViewModel.isDone == false
                          ? "Not Complete"
                          : "Completed",
                      topicIcon: Icons.done_outline_outlined,
                      color: addTaskViewModel.isDone == false
                          ? Colors.white
                          : Colors.green,
                      topic: "Task Complete"),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TaskDeleteDialog(
                                      title: task.title,
                                      function: () async {
                                        await addTaskViewModel.deleteTodo(
                                            id: task.key);
                                        await taskListViewModel
                                            .getAllTasks(isDone: false)
                                            .whenComplete(() =>
                                                Fluttertoast.showToast(
                                                        msg:
                                                            'Task deleted Successfully')
                                                    .whenComplete(() =>
                                                        openHome(context)));
                                      });
                                });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline_rounded,
                                color: kPrimaryErrorColor,
                                size: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Delete Task",
                                style: TextStyle(
                                    fontSize: 18, color: kPrimaryErrorColor),
                              )
                            ],
                          )),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  ButtonField(
                    onpress: () async {
                      setState(() {
                        addTaskViewModel.isDone = isDone;
                        addTaskViewModel.date = _selectedDate;
                      });

                      await addTaskViewModel.updateTodo(
                          id: widget.taskModel.key);
                      await taskListViewModel
                          .getAllTasks(isDone: false)
                          .whenComplete(() => Fluttertoast.showToast(
                              msg: 'Task updated Successfully'))
                          .whenComplete(() => Navigator.pop(context));
                    },
                    text: "Edit Task",
                    pleft: size.width * 0.3,
                    pright: size.width * 0.3,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  )
                ],
              )
            ],
          )),
    );
  }

  _getCalendar(DateTime date) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.day,
        initialDate: date,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (newDate == null) {
      return;
    }
    setState(() {
      _selectedDate = newDate;
    });
  }
}
