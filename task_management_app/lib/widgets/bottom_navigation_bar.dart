import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import "package:task_management_app/utils/constraints.dart";
import 'package:task_management_app/screens/Task/home_screen.dart';
import 'package:task_management_app/view%20models/task%20view%20models/add_task_view_model.dart';
import 'package:task_management_app/view%20models/task%20view%20models/task_list_view_model.dart';
import "package:task_management_app/widgets/text_field.dart";
import "package:task_management_app/services/validator/validate_handeler.dart";
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  final String? userId;
  const BottomNavBar({super.key, this.userId});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 1;
  late DateTime _selectedDate;
  late TimeOfDay _timeOfDay;
  final List<Widget> _screens = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _form = GlobalKey<FormState>();
  late AddTaskViewModel addTaskViewModel;
  late TaskListViewModel taskListViewModel;

  bool isSelected = false;
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    Hive.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    addTaskViewModel = Provider.of<AddTaskViewModel>(context, listen: false);
    taskListViewModel = Provider.of<TaskListViewModel>(context, listen: false);

    _screens.addAll([
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              selectedIconTheme: IconThemeData(color: kPrimaryButtonColor),
              type: BottomNavigationBarType.fixed,
              backgroundColor: kPrimaryBackgroundColor,
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kPrimaryButtonColor,
                    ),
                    child: IconButton(
                        onPressed: () {
                          _showAddModal(context);
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 30,
            top: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Task",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  TextFieldWidget(
                    label: "Title",
                    onchange: (value) {},
                    valid: (value) {
                      return Validator.generalValid(value!);
                    },
                    save: (value) {},
                    controller: titleController,
                  ),
                  TextFieldWidget(
                    focusNode: _focusNode,
                    label: "Description",
                    onchange: (value) {},
                    valid: (value) {
                      return Validator.generalValid(value!);
                    },
                    save: (value) {},
                    controller: descriptionController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () async {
                              if (_focusNode.hasFocus) {
                                _focusNode.unfocus();
                              }
                              await _getCalendar();
                            },
                            icon: Icon(Icons.calendar_month_outlined),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              _addTodo();
                            },
                            icon: Icon(
                              Icons.send_outlined,
                              color: kPrimaryButtonColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _getCalendar() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.day,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (newDate == null) {
      return;
    }
    setState(() {
      _selectedDate = newDate;
    });
  }

  _addTodo() async {
    if (_form.currentState!.validate()) {
      addTaskViewModel.title = titleController.text;
      addTaskViewModel.description = descriptionController.text;
      addTaskViewModel.date = _selectedDate;
      addTaskViewModel.isDone = false;
      addTaskViewModel.priority = "HIGH";
      await addTaskViewModel.addTodo();
      await taskListViewModel.getAllTasks().whenComplete(() =>
          Fluttertoast.showToast(msg: 'Task added Successfully')
              .whenComplete(() => Navigator.pop(context)));
    }
  }
}
