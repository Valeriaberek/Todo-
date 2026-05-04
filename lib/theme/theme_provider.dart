import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;
  MaterialColor color = Colors.indigo;

  void toggleDark() {
    isDark = !isDark;
    notifyListeners();
  }

  void changeColor(MaterialColor newColor) {
    color = newColor;
    notifyListeners();
  }

  ThemeData get theme {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primarySwatch: color,
    );
  }
}