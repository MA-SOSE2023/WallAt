import 'dart:ui';

import 'package:device_calendar/device_calendar.dart';

import 'settings_model.dart';
import 'settings_view.dart';

var settings = SettingsModel(
  calendar: null,
  brightness: Brightness.light,
);

class SettingsControllerImpl extends SettingsController {
  SettingsControllerImpl({SettingsModel? model}) : super(model ?? settings);

  @override
  bool isDarkMode() {
    return state.brightness == Brightness.dark;
  }

  @override
  void setUsedCalendar(Calendar calendar) {
    state = state.copyWith(calendar: calendar);
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
