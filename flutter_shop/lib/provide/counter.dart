import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  var number = 0;
  increment() {
    number++;
    notifyListeners();
  }

  decrement() {
    number--;
    notifyListeners();
  }
}
