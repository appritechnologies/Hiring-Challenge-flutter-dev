
import 'package:task_management_app/models/boxes.dart';
import 'package:task_management_app/models/task_model.dart';

class HiveHandler {
  //getTaskList
  static Future<List<TaskModel>> getAllTasks() async {
    List<TaskModel> enlist = [];
    TaskModel model;
    enlist = Boxes.getTasks().values.toList();
    return enlist;
  }
}
