import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String appLanguage = 'en';
   void changeLanguage(String newLanguage) {
    if (newLanguage == appLanguage) {
      return;
    }
    appLanguage = newLanguage;

    notifyListeners();
  }
}
