import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//images
const logo = "assets/images/logo.png";


//animation
const loadingAnim = "assets/json/loading.json";
const todoAnim = "assets/json/todo.json";

//don't change black its effect to the calendar
ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.white,
  colorScheme: ColorScheme(
    background: Colors.white,
    brightness: Brightness.dark,
    primary: kPrimaryButtonColor,
    onPrimary: Colors.black,
    onBackground: Colors.white,
    secondary: Colors.white,
    onSurface: Colors.white,
    onSecondary: Colors.white,
    error: kPrimaryErrorColor,
    onError: kPrimaryErrorColor,
    surface: Colors.black,
  ).copyWith(secondary: Colors.white),
);

const Color kPrimaryButtonColor = Color(0xFF00B0F0);

const Color kPrimaryBackgroundColor = Color(0xFFffffff);

const Color kPrimaryTileColor = Color(0xFF272727);

const kPrimaryTextColor = Color(0xFFAFAFAF);

const kPrimaryErrorColor = Color(0xFFFF4949);

class Convert {
  static String getColorString({required Color color}) {
    String colorString = color.toString();
    RegExp regExp = RegExp(
        r"0xff([a-fA-F0-9]+)"); // Matches "0xff" followed by any number of hexadecimal digits
    RegExpMatch? match = regExp
        .firstMatch(colorString); // Search for the pattern in the color string
    String? hexValue =
        match?.group(1); // Extract the hexadecimal value from the match
    print(hexValue);
    return hexValue.toString();
  }

  static String getTime({required String time}) {
    List<String> parts = time.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);
    final DateFormat formatter = DateFormat('h:mm a');
    String timeString = formatter
        .format(DateTime(2023, 1, 1, timeOfDay.hour, timeOfDay.minute));
    return timeString;
  }

  static TimeOfDay convertTime({required String time}) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd hh:mm a');
    DateTime dateTime = dateFormat.parse('1970-01-01 $time');
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
    return timeOfDay;
  }

  static String convertTimeOfDayToString({required TimeOfDay time}) {
    int h = time.hour;
    int m = time.minute;
    TimeOfDay timeOfDay = TimeOfDay(hour: h, minute: m);
    String formattedTime = DateFormat('hh:mm a')
        .format(DateTime(2022, 1, 1, timeOfDay.hour, timeOfDay.minute));
    return formattedTime;
  }

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

  static String timeFormat(String foregroundTime) {
    var foregroundUsageInMinutes = double.parse(foregroundTime) / 1000 / 60;
    int totalMinutes = foregroundUsageInMinutes.round();
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;
    String formattedTime =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    return formattedTime;
  }
}
