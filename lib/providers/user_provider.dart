import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:to_do/models/my_user.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;
  SharedPreferences? sharedPreferences;
  void updateUser({required MyUser? newUser}) {
    currentUser = newUser;
    debugPrint('====== User Saved in Provider ==============');
    notifyListeners();
  }

  Future<void> saveUser(bool isLoggedIn) async {
    await sharedPreferences!.setBool('isLoggedIn', isLoggedIn);
  }

  bool? getUser() {
    return sharedPreferences!.getBool('isLoggedIn');
  }

  Future<void> setItems() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if(getUser() ?? false)
    {
      
    }
  }
}
