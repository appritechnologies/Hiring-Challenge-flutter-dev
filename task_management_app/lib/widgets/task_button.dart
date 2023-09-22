import 'package:flutter/material.dart';
import 'package:task_management_app/utils/constraints.dart';

class TaskRow extends StatelessWidget {
  final String text;
  final IconData? btnIcon;
  final IconData topicIcon;
  final String topic;
  final Color color;
  final Function function;
  const TaskRow(
      {Key? key,
      required this.text,
      this.btnIcon,
      required this.topicIcon,
      required this.topic,
      required this.function,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(topicIcon),
            SizedBox(
              width: size.width * 0.01,
            ),
            Text("$topic:")
          ],
        ),
        InkWell(
          onTap: () {
            function();
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kPrimaryTileColor),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.015),
                child: Row(
                  children: [
                    if (btnIcon != null) ...[
                      Icon(
                        btnIcon,
                        color: Colors.white,
                      ),
                      SizedBox(width: size.width * 0.01),
                    ],
                    Text(
                      text,
                      style: TextStyle(fontSize: 15, color: color),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
