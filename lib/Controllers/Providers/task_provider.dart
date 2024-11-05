import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Models/taskModel.dart';

class Tasks extends ChangeNotifier {
  List<TaskModel> userTask = [];


  void addTaskModel(TaskModel newUserTask) {
    userTask.add(newUserTask);
    notifyListeners();
  }

  void deleteTaskModel(int index) {
    userTask.removeAt(index);
    notifyListeners();
  }

  void editTaskModel(int index,TaskModel newUserTask) {
    userTask[index] = newUserTask;
    notifyListeners();
  }

}

