import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/firebase%20utils/firebase_utils.dart';
import 'package:to_do/models/task_model.dart';

class ListProvider extends ChangeNotifier {
  // حط الداتا اللى هتاثر على كذا ويدجت
  // حط الميثود اللى هتغير على الداتا
  List<Task> tasks = [];
  bool isDone = false;
  DateTime selectedDate = DateTime.now();
  void getAllTasks() async {
    var taskCollectionRef = FireBaseUtils.getCollectionRef();
    QuerySnapshot<Task> querySnapshots = await taskCollectionRef.get();
    tasks = querySnapshots.docs.map((docs) {
      return docs.data();
    }).toList();

    //filter list based on selected date

    tasks = tasks.where((task) {
      if (task.date?.day == selectedDate.day &&
          task.date?.month == selectedDate.month &&
          task.date?.year == selectedDate.year) {
        return true;
      } else {
        return false;
      }
    }).toList();
    //now we have a list of tasks for the selected date
    // now we want to sort them based on their date
    tasks.sort((task1, task2) {
      return task1.date!.compareTo(task2.date!);
    });

    notifyListeners();
    //كان ممكن نستغني عن الكلام ده كله بالquerires اللى موجودهخ فى الدوكيومنتيشن فى الفايربيز
  }

  Future<void> updateUser(
      Task task, String? title, String? description, DateTime? date) {
    var ref = FireBaseUtils.getCollectionRef();
    return ref.doc(task.id).update({
      'title': title ?? task.title,
      'description': description ?? task.description,
      'date': date?.millisecondsSinceEpoch ?? task.date!.millisecondsSinceEpoch,
    });
  }

  void cahngeSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    //get tasks again after selecting new date
    getAllTasks();
  }
}
