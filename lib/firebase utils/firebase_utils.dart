import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/consts.dart';
import 'package:to_do/models/task_model.dart';

class FireBaseUtils {
  static Future<void> addTask(Task task) {
    var taskCollectionRef = getCollectionRef();
    DocumentReference<Task> taskDocRef = taskCollectionRef.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static CollectionReference<Task> getCollectionRef() {
    return FirebaseFirestore.instance
        .collection(kTaskCollection)
        .withConverter<Task>(
          fromFirestore: (snapShot, options) => Task.fromJson(snapShot.data()),
          toFirestore: (task, options) => task.toJson(),
        );
  }

  
}
