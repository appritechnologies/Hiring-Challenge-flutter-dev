import 'package:flutter/material.dart';
import 'package:task_management_app/utils/constraints.dart';
import 'package:task_management_app/widgets/button_field.dart';

class TaskDeleteDialog extends StatefulWidget {
  final String title;
  final Function function;
  const TaskDeleteDialog(
      {Key? key, required this.title, required this.function})
      : super(key: key);

  @override
  State<TaskDeleteDialog> createState() => _TaskDeleteDialogState();
}

class _TaskDeleteDialogState extends State<TaskDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        height: size.height * 0.3,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02, vertical: size.height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Delete Task",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "Are You sure you want to delete this task?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                "Task title: ${widget.title}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style:
                            TextStyle(color: kPrimaryButtonColor, fontSize: 20),
                      )),
                  ButtonField(
                    onpress: () {
                      widget.function();
                    },
                    text: "Delete",
                    pright: size.width * 0.15,
                    pleft: size.width * 0.15,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
