import 'package:flutter/material.dart';
import 'package:task_management_app/utils/constraints.dart';

class ToggleBtn extends StatefulWidget {
  final List<String> toggleButtonOptions;
  final List<bool> isSelectedOptions;
  final Function(int) onSelect;
  final String? initialPriority;
  const ToggleBtn(
      {super.key,
      required this.toggleButtonOptions,
      required this.isSelectedOptions,
      required this.onSelect,
      this.initialPriority});
  @override
  _ToggleBtnState createState() => _ToggleBtnState();
}

class _ToggleBtnState extends State<ToggleBtn> {
  @override
  void initState() {
    super.initState();
    if (widget.initialPriority != null) {
      int initialIndex =
          widget.toggleButtonOptions.indexOf(widget.initialPriority!);
      print(initialIndex);
      if (initialIndex != -1) {
        for (int i = 0; i < widget.isSelectedOptions.length; i++) {
          widget.isSelectedOptions[i] = (i == initialIndex);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ToggleButtons(
      selectedColor: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      fillColor: kPrimaryButtonColor,
      isSelected: widget.isSelectedOptions,
      onPressed: (int index) {
        setState(() {
          widget.onSelect(index);
        });
      },
      children: widget.toggleButtonOptions
          .map((option) => Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.05),
                child: Text(
                  option,
                  style: TextStyle(fontSize: 15),
                ),
              ))
          .toList(),
    );
  }
}
