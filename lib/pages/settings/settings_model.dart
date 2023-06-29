import 'dart:ui';

import 'package:device_calendar/device_calendar.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    Calendar? calendar,
    required int selectedThemeIndex,
    required int selectedProfileIndex,
  }) = _SettingsModel;
}
