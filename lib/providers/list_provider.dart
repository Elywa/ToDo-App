import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/firebase%20utils/firebase_utils.dart';
import 'package:to_do/models/task_model.dart';

class ListProvider extends ChangeNotifier {
  // حط الداتا اللى هتاثر على كذا ويدجت
  // حط الميثود اللى هتغير على الداتا
  List<Task> tasks = [];
  void getAllTasks() async {
    var taskCollectionRef = FireBaseUtils.getCollectionRef();
    QuerySnapshot<Task> querySnapshots = await taskCollectionRef.get();
    tasks = querySnapshots.docs.map((docs) {
      return docs.data();
    }).toList();
    notifyListeners();
  }
}
