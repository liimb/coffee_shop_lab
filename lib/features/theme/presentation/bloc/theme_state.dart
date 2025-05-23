import 'package:flutter/material.dart';

enum Themes {
  light,
  dark
}

class ThemeState {
  const ThemeState({required this.themeMode});

  final ThemeMode themeMode;
}
