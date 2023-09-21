import 'package:hive/hive.dart';
import 'package:task_management_app/models/task_model.dart';

class Boxes {
  static Box<TaskModel> getTasks() => Hive.box<TaskModel>('tasks');
}
