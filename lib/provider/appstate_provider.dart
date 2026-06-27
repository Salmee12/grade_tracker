// app_state_provider.dart
import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  int _currentIndex = 0;
  bool _isDarkMode = false;

  int get currentIndex => _currentIndex;
  bool get isDarkMode => _isDarkMode;

  void changePage(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setTheme(bool dark) {
    _isDarkMode = dark;
    notifyListeners();
  }
}