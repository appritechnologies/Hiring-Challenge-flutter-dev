import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//images
const logo = "assets/images/logo.png";

//animation
const loadingAnim = "assets/json/loading.json";
const todoAnim = "assets/json/task.json";

const Color kPrimaryButtonColor = Color(0xFF00B0F0);

const Color kPrimaryBackgroundColor = Color(0xFFffffff);

const Color kPrimaryTileColor = Color(0xFF272727);

const kPrimaryTextColor = Color(0xFFAFAFAF);

const kPrimaryErrorColor = Color(0xFFFF4949);

class Convert {
  static String getDate({required DateTime date}) {
    date = DateTime(date.year, date.month, date.day);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    if (date.isAtSameMomentAs(today)) {
      return "Today ";
    } else if (date.isAtSameMomentAs(today.add(Duration(days: 1)))) {
      return "Tomorrow ";
    } else if (date.isAtSameMomentAs(today.subtract(Duration(days: 1)))) {
      return "Yesterday ";
    } else {
      String day = "${DateFormat('yyyy MMMM d').format(date)} ";
      return day;
    }
  }

  static String upperCase({required String text}) {
    String capitalizedText =
        text.substring(0, 1).toUpperCase() + text.substring(1);
    return capitalizedText;
  }
}
