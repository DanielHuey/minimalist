import 'package:flutter/material.dart';

class Theme with ChangeNotifier {
  static bool _isLightTheme = true;
  final List<ThemeData> _thList = [
    ThemeData(
      scaffoldBackgroundColor: Colors.pinkAccent,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[800],
      ),
    ),
    ThemeData(
      scaffoldBackgroundColor: Colors.grey[800],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.black54,
        foregroundColor: Colors.grey[400],
      ),
    ),
  ];
  ThemeData theme(bool isLight) {
    return isLight ? _thList[0] : _thList[1];
  }

  void switchTheme() {
    _isLightTheme = !_isLightTheme;
    notifyListeners();
  }

  ThemeMode currentMode() {
    return _isLightTheme ? ThemeMode.light : ThemeMode.dark;
  }
}
