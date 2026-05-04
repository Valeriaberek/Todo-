import 'package:flutter/material.dart';

const Color _seedColor = Color(0xFFFF77B0); // bubble-gum

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: _seedColor, brightness: Brightness.light),
  useMaterial3: true,
);

final ThemeData appDarkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: _seedColor, brightness: Brightness.dark),
  useMaterial3: true,
);
