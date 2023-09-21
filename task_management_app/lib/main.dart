import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/screens/intro/splash_screen.dart';
import 'package:task_management_app/view%20models/task%20view%20models/add_task_view_model.dart';
import 'package:task_management_app/view%20models/task%20view%20models/task_list_view_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasks');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AddTaskViewModel()),
    ChangeNotifierProvider(create: (_) => TaskListViewModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
