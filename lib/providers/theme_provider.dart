import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode myTheme = ThemeMode.light;
  void changeTheme(ThemeMode newMode) {
    if (myTheme == newMode) {
      return;
    }
    myTheme = newMode;
    notifyListeners();
  }

  bool isDark() {
    return myTheme == ThemeMode.dark;
  }
}
