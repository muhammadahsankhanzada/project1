import 'package:flutter/material.dart';

class DummyProvider extends ChangeNotifier {
  int _num = 1;
  getInt(int num) {
    _num = num;
    print(_num);
    // notifyListeners();
  }
}
