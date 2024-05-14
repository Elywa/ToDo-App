import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/consts.dart';
import 'package:to_do/models/my_user.dart';
import 'package:to_do/models/task_model.dart';

class FireBaseUtils {
  static Future<void> addTask(Task task, String uId) {
    var taskCollectionRef = getTaskCollectionRef(uId);
    DocumentReference<Task> taskDocRef = taskCollectionRef.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static CollectionReference<Task> getTaskCollectionRef(String uId) {
    return getUserCollectionRef()
        .doc(uId)
        .collection(kTaskCollection)
        .withConverter<Task>(
          fromFirestore: (snapShot, options) => Task.fromJson(snapShot.data()),
          toFirestore: (task, options) => task.toJson(),
        );
  }

  static Future<void> deleteTask(Task task, String uId) {
    var ref = getTaskCollectionRef(uId);
    return ref.doc(task.id).delete();
  }

  static Future<void> updateTaskeIsDone(Task task, String uId) {
    var ref = getTaskCollectionRef(uId);

    return ref.doc(task.id).update({'isDone': !task.isDone!});
  }

  static CollectionReference<MyUser> getUserCollectionRef() {
    final userCollectionRef = FirebaseFirestore.instance
        .collection(MyUser.userCollection)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toFireStore(),
        );
    return userCollectionRef;
  }

  static Future<void> addUserToFireStore(MyUser user) {
    var userRef = getUserCollectionRef();
    DocumentReference<MyUser> docRef = userRef.doc(user.id);
    return docRef.set(user);
  }

  static Future<MyUser?> getUserFromFireStore(String userId) async {
    var querySnapshot = await getUserCollectionRef().doc(userId).get();
    return querySnapshot.data();
  }

  static Future<void> signOut() async {
    var signOutUser = await FirebaseAuth.instance.signOut();
    return signOutUser;
  }
}
