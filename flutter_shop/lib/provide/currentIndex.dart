import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier {
  int currentIndex = 0;

  changeIndex(int newIndex) async {
    currentIndex = newIndex;
    notifyListeners();
  }
}
