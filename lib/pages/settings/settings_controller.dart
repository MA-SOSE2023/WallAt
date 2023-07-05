import 'package:device_calendar/device_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_model.dart';
import 'settings_view.dart';
import '/common/utils/device_calendar_mixin.dart';

enum Settings {
  calendar,
  selectedColorTheme,
  selectedProfile,
  availableProfiles,
}

SettingsModel _settings = const SettingsModel(
  calendar: null,
  selectedThemeIndex: 1,
  selectedProfileIndex: 0,
);

class SettingsControllerImpl extends SettingsController
    with DeviceCalendarMixin {
  SettingsControllerImpl({SettingsModel? model}) : super(model ?? _settings) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = state.copyWith(
      calendar: await getCalendarById(prefs.getString(Settings.calendar.name)),
      selectedThemeIndex: prefs.getInt('selectedThemeIndex') ?? 1,
      selectedProfileIndex: prefs.getInt('selectedProfileIndex') ?? 0,
    );
  }

  @override
  void setUsedCalendar(Calendar? calendar) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (calendar != null && calendar.id != null) {
      prefs.setString(Settings.calendar.name, calendar.id!);
    }
    state = state.copyWith(calendar: calendar);
  }

  @override
  void changeThemeIndex(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedThemeIndex', index);
    state = state.copyWith(selectedThemeIndex: index);
  }

  @override
  void setProfileIndex(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedProfileIndex', index);
    state = state.copyWith(selectedProfileIndex: index);
  }
}
