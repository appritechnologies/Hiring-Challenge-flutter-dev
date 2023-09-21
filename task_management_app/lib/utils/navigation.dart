import 'package:flutter/material.dart';
import 'package:task_management_app/widgets/bottom_navigation_bar.dart';

void openHome(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
}
