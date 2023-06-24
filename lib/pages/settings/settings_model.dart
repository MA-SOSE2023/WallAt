import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    String? calendarId,
    required Brightness brightness,
  }) = _SettingsModel;
}
