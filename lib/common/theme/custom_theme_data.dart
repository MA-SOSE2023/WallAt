import 'package:flutter/material.dart';

class CustomThemeData {
  final String name;
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color groupingColor;
  final Color textColor;
  final Color navBarColor;

  CustomThemeData.lightTheme({
    this.name = 'Light Theme',
    this.primaryColor = const Color.fromARGB(255, 174, 174, 178),
    this.accentColor = const Color.fromARGB(255, 0, 122, 255),
    this.backgroundColor = const Color.fromARGB(255, 255, 255, 255),
    this.groupingColor = const Color.fromARGB(255, 174, 174, 178),
    this.textColor = const Color.fromARGB(255, 0, 0, 0),
    this.navBarColor = const Color.fromARGB(255, 211, 211, 211),
  });

  CustomThemeData.darkTheme({
    this.name = 'Light Theme',
    this.primaryColor = const Color(0xFF1E1E1E),
    this.accentColor = const Color.fromARGB(255, 0, 122, 255),
    this.backgroundColor = const Color.fromARGB(255, 29, 29, 29),
    this.groupingColor = const Color(0xFF1E1E1E),
    this.textColor = const Color.fromARGB(255, 255, 255, 255),
    this.navBarColor = const Color(0xFF1E1E1E),
  });
}

List<CustomThemeData> selectableThemes = [
  CustomThemeData.lightTheme(),
  CustomThemeData.darkTheme(),
];
