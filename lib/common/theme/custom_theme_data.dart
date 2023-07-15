import 'package:flutter/material.dart';

import '/common/localization/language.dart';

class CustomThemeData {
  final String name;
  final Brightness brightness;
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color groupingColor;
  final Color textColor;
  final Color navBarColor;
  final LinearGradient gradient;

  CustomThemeData.lightTheme({
    this.brightness = Brightness.light,
    this.primaryColor = const Color.fromARGB(255, 174, 174, 178),
    this.accentColor = const Color(0xFF125991),
    this.backgroundColor = const Color.fromARGB(255, 255, 255, 255),
    this.groupingColor = const Color.fromARGB(255, 212, 212, 217),
    this.textColor = const Color.fromARGB(255, 0, 0, 0),
    this.navBarColor = const Color.fromARGB(255, 211, 211, 211),
    required Language language,
  })  : gradient = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            groupingColor,
            accentColor,
          ],
        ),
        name = language.lblLightTheme;

  CustomThemeData.darkTheme({
    this.brightness = Brightness.dark,
    this.primaryColor = const Color(0xFF1E1E1E),
    this.accentColor = const Color.fromARGB(255, 0, 122, 255),
    this.backgroundColor = const Color.fromARGB(255, 29, 29, 29),
    this.groupingColor = const Color.fromARGB(255, 82, 82, 85),
    this.textColor = const Color.fromARGB(255, 255, 255, 255),
    this.navBarColor = const Color.fromARGB(255, 54, 56, 63),
    required Language language,
  })  : gradient = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            groupingColor,
            accentColor,
          ],
        ),
        name = language.lblDarkTheme;

  CustomThemeData.oceanTheme({
    this.brightness = Brightness.dark,
    this.primaryColor = const Color(0xFF1E1E1E),
    this.accentColor = const Color.fromARGB(255, 72, 131, 194),
    this.backgroundColor = const Color.fromARGB(255, 4, 1, 22),
    this.groupingColor = const Color.fromARGB(255, 83, 83, 110),
    this.textColor = const Color.fromARGB(255, 255, 255, 255),
    this.navBarColor = const Color.fromARGB(255, 38, 41, 56),
    required Language language,
  })  : gradient = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            groupingColor,
            accentColor,
          ],
        ),
        name = language.lblOceanTheme;

  CustomThemeData.hotDogStandTheme({
    this.brightness = Brightness.dark,
    this.primaryColor = const Color(0xFF1E1E1E),
    this.accentColor = const Color.fromARGB(255, 255, 255, 0),
    this.backgroundColor = const Color.fromARGB(255, 255, 0, 0),
    this.groupingColor = const Color.fromARGB(255, 255, 0, 0),
    this.textColor = const Color.fromARGB(255, 255, 255, 255),
    this.navBarColor = const Color.fromARGB(255, 255, 0, 0),
    required Language language,
  })  : gradient = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            groupingColor,
            accentColor,
          ],
        ),
        name = language.lblHotDogStandTheme;
}

List<CustomThemeData> selectableThemes(Language language) => [
      CustomThemeData.lightTheme(language: language),
      CustomThemeData.darkTheme(language: language),
      CustomThemeData.oceanTheme(language: language),
      CustomThemeData.hotDogStandTheme(language: language),
    ];
