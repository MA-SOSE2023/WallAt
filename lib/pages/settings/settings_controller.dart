import 'dart:ui';

import 'settings_model.dart';
import 'settings_view.dart';

var settings = SettingsModel(
  calendarId: null,
  brightness: Brightness.light,
);

class SettingsControllerImpl extends SettingsController {
  SettingsControllerImpl({SettingsModel? model}) : super(model ?? settings);

  @override
  bool isDarkMode() {
    return state.brightness == Brightness.dark;
  }

  @override
  void toggleColorTheme(bool value) {
    if (value) {
      state = state.copyWith(brightness: Brightness.dark);
    } else {
      state = state.copyWith(brightness: Brightness.light);
    }
  }
}
