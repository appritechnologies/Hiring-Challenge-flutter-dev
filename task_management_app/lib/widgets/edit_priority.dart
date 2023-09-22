import 'package:flutter/material.dart';
import 'package:task_management_app/utils/constraints.dart';
import 'package:task_management_app/widgets/button_field.dart';
import 'package:task_management_app/widgets/toggle_button.dart';

class EditPriority extends StatefulWidget {
  final Function onSave;
  final String priority;
  final Function(int) onSelect;
  final List<String> toggleButtonOptions;
  final List<bool> isSelectedOptions;
  const EditPriority(
      {super.key,
      required this.onSave,
      required this.onSelect,
      required this.priority,
      required this.toggleButtonOptions,
      required this.isSelectedOptions});

  @override
  State<EditPriority> createState() => _EditPriorityState();
}

class _EditPriorityState extends State<EditPriority> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.03),
        child: SizedBox(
          height: size.height * 0.23,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Edit Priority",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ToggleBtn(
                  initialPriority: widget.priority,
                  toggleButtonOptions: widget.toggleButtonOptions,
                  isSelectedOptions: widget.isSelectedOptions,
                  onSelect: widget.onSelect),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
