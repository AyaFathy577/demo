import 'package:flutter/material.dart';

class TabsProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  updateCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
  initCurrentIndex() {
    _currentIndex = 0;
  }
}
