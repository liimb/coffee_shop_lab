import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: Color(0xFF5CBCE5),
        secondary: Color(0xFFF7FAF8),
        surface: Color(0xFF1E1E1E),
      ),
      cardColor: Colors.white
  );

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: Color(0xFF53C1F0),
        secondary: Color(0xFFF7FAF8),
        surface: Color(0xFF313031),
      ),
      cardColor: Color(0xFF484647)
  );

}
