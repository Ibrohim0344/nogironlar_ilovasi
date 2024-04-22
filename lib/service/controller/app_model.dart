import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  String locale = "uz";

  void changeAppLanguage(String newLocale) {
    locale = newLocale;
    notifyListeners();
  }
}
