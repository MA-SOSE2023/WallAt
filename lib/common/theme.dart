import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color primaryColor       = Color(0xFF84BAF5);
  static const Color accentColor        = Color(0xFF125991);
  static const Color scaffoldColorDark  = Color(0xFF424549);
  static const Color scaffoldColorLight = Color(0xFFEEEEEF);
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