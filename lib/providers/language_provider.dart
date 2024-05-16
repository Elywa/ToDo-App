import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String appLanguage = 'en';
  SharedPreferences? sharedPreferences;
  void changeLanguage(String newLanguage) {
    if (newLanguage == appLanguage) {    
      return;
    }
    appLanguage = newLanguage;
    if (appLanguage == 'ar') {
      saveLanguage(true);
    } else {
      saveLanguage(false);
    }
    notifyListeners();
  }

  Future<void> saveLanguage(bool isArabic) async {
    await sharedPreferences!.setBool("isArabic", isArabic);
  }

  bool? getLanguage() {
    return sharedPreferences!.getBool('isArabic');
  }

  Future<void> setItems() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (getLanguage() ?? false) {
      appLanguage = 'ar';
    } else {
      appLanguage = 'en';
    }
  }
}
