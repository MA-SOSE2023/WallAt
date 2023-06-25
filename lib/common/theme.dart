import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF84BAF5);
  static const Color accentColor = Color(0xFF125991);
}

class AppCupertinoTheme {
  
  static const CupertinoThemeData lightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    primaryContrastingColor: AppColors.accentColor,
    barBackgroundColor: CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.systemBackground,
      darkColor: CupertinoColors.darkBackgroundGray,
    ),
  );

  static const CupertinoThemeData darkTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    primaryContrastingColor: AppColors.accentColor,
    barBackgroundColor: CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.systemBackground,
      darkColor: CupertinoColors.darkBackgroundGray,
    ),
  );
}