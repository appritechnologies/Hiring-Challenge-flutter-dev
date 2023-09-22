import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_management_app/utils/navigation.dart';

import '../../utils/constraints.dart';

class SplashScreen extends StatefulWidget {
  static const routName = 'splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);

    return new Timer(duration, route);
  }

  route() async {
    openHome(context);
  }

  initScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Icon(
            Icons.task_alt_outlined,
            color: kPrimaryButtonColor,
            size: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Task",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
              Text(
                "Minder",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryButtonColor),
              ),
            ],
          ),
          Lottie.asset(loadingAnim,
              width: size.width * 0.3, height: size.width * 0.3),
          SizedBox(
            height: size.height * 0.2,
          ),
          Text(
            "Copyright 2023 © Task Minder ",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: kPrimaryButtonColor,
            ),
          ),
        ],
      ),
    ));
  }
}
