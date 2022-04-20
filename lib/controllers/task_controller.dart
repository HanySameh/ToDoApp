import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/db/db_helper.dart';
import 'package:to_do/ui/pages/completed_task_screen.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  RxList<Task>? taskList = <Task>[].obs;
  RxList<Task>? taskCompletedList;
  RxList<Task>? todayTaskList;
  RxList<Task>? learningTaskList;
  RxList<Task>? personalTaskList;
  RxList<Task>? workTaskList;
  RxList<Task>? fitnessTaskList;

  Future addTask({Task? task}) async {
    try {
      return await DBHelper.insertToDb(task);
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> getTasks() async {
    taskCompletedList = <Task>[].obs;
    todayTaskList = <Task>[].obs;
    learningTaskList = <Task>[].obs;
    personalTaskList = <Task>[].obs;
    workTaskList = <Task>[].obs;
    fitnessTaskList = <Task>[].obs;
    try {
      print('get state');
      final List<Map<String, dynamic>> tasks = await DBHelper.query();

      tasks.forEach((element) {
        if (element['isCompleted'] == 1) {
          taskCompletedList!.add(Task.fromJson(element));
          print('Completed tasks $tasks');
        }
        if ((element['date'] == DateFormat.yMd().format(DateTime.now()) ||
                element['repeat'] == 'Daily') &&
            element['isCompleted'] == 0) {
          todayTaskList!.add(Task.fromJson(element));
          // taskList!.add(Task.fromJson(element));
          print('Today tasks $tasks');
        }
        if (element['category'] == 'learning') {
          learningTaskList!.add(Task.fromJson(element));
        }
        if (element['category'] == 'personal') {
          personalTaskList!.add(Task.fromJson(element));
        }
        if (element['category'] == 'work') {
          workTaskList!.add(Task.fromJson(element));
        }
        if (element['category'] == 'fitness') {
          fitnessTaskList!.add(Task.fromJson(element));
        }
      });
      // tasks.map((element) {
      //   if (element['isCompleted'] == 1) {
      //     taskCompletedList!
      //         .assignAll(tasks.map((element) => Task.fromJson(element)).toList());
      //     print('Completed tasks $tasks');
      //   } else {
      //     taskList!.assignAll(
      //         tasks.map((element) => Task.fromJson(element)).toList());
      //     print(tasks);
      //   }
      // }).toList();
      taskList!
          .assignAll(tasks.map((element) => Task.fromJson(element)).toList());
      print(tasks);
    } catch (error) {
      print(error.toString());
    }
  }

  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTasks();
  }

  void taskCompleted(int id) async {
    await DBHelper.updateDb(id);
    getTasks();
  }

  void updateTask(Task task) async {
    try {
      await DBHelper.updatetask(task);
      getTasks();
    } catch (error) {
      print(error.toString());
    }
  }
}
