import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode myTheme = ThemeMode.light;
  SharedPreferences? sharedPreferences;
  void changeTheme(ThemeMode newMode) {
    if (myTheme == newMode) {
      return;
    }
    myTheme = newMode;

    if (myTheme == ThemeMode.light) {
      saveTheme(false);
    } else {
      saveTheme(true);
    }

    notifyListeners();
  }

  bool isDark() {
    return myTheme == ThemeMode.dark;
  }

  Future<void> saveTheme(bool isDark) async {
    await sharedPreferences!.setBool('isDark', isDark);
  }

  bool? getTheme() {
    return sharedPreferences!.getBool('isDark');
  }

  Future<void> setItems() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (getTheme() ?? false) {
      myTheme = ThemeMode.dark;
    } else {
      myTheme = ThemeMode.light;
    }
  }
}
