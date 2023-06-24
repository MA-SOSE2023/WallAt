import 'dart:ui';

import 'settings_model.dart';
import 'settings_view.dart';

var settings = SettingsModel(
  calendarId: null,
  brightness: Brightness.light,
);

class SettingsControllerImpl extends SettingsController {
  SettingsControllerImpl({SettingsModel? model}) : super(model ?? settings);
}
