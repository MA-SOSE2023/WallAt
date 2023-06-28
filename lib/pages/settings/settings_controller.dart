import 'dart:ui';

import 'package:device_calendar/device_calendar.dart';

import 'settings_model.dart';
import 'settings_view.dart';

var settings = SettingsModel(
  calendar: null,
  selectedThemeIndex: 1,
);

class SettingsControllerImpl extends SettingsController {
  SettingsControllerImpl({SettingsModel? model}) : super(model ?? settings);

  @override
  void setUsedCalendar(Calendar? calendar) {
    state = state.copyWith(calendar: calendar);
  }

  @override
  void changeThemeIndex(int index) {
    state = state.copyWith(selectedThemeIndex: index);
  }
}
