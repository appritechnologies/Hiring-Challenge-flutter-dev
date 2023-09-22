import 'package:flutter/material.dart';
import 'package:task_management_app/utils/constraints.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextInputType keybordtype;
  final Icon? prefixIcon;
  final TextEditingController controller;
  final String hintText;

  final TextInputAction textInputAction;
  final Function(String) onchange;
  final Function(String?) save;
  final FocusNode? focusNode;
  final String? Function(String?) valid;
  const TextFieldWidget({
    this.focusNode,
    this.textInputAction = TextInputAction.none,
    this.hintText = "Text",
    required this.onchange,
    required this.valid,
    required this.save,
    Key? key,
    required this.controller,
    this.label = "Textfiled",
    this.keybordtype = TextInputType.text,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        focusNode: focusNode,
        autofocus: false,
        textInputAction: textInputAction,
        maxLines: null,
        keyboardType: keybordtype,
        onChanged: onchange,
        onSaved: save,
        controller: controller,
        validator: valid,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Color(0xFFE2E5E6), // Change this to your desired color
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Color(0xFFE2E5E6), // Change this to your desired color
              width: 1.0,
            ),
          ),
          label: Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
