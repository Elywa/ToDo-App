import 'package:flutter/foundation.dart';
import 'package:to_do/models/my_user.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser({required MyUser? newUser}) {
    currentUser = newUser;
    debugPrint('====== User Saved in Provider ==============');
    notifyListeners();
  }
}
