import 'package:device_calendar/device_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/common/localization/language.dart';
import 'settings_model.dart';
import 'settings_view.dart';
import '/common/utils/device_calendar_mixin.dart';

enum Settings {
  calendar,
  selectedColorTheme,
  selectedProfile,
  language,
}

SettingsModel _settings = const SettingsModel(
  calendar: null,
  selectedThemeIndex: 1,
  selectedProfileId: null,
  language: Language.en,
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
      selectedThemeIndex: prefs.getInt(Settings.selectedColorTheme.name) ?? 1,
      selectedProfileId: prefs.getInt(Settings.selectedProfile.name),
      language: Language.of(prefs.getString(Settings.language.name) ?? 'en'),
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
    prefs.setInt(Settings.selectedColorTheme.name, index);
    state = state.copyWith(selectedThemeIndex: index);
  }

  @override
  void setProfileId(int profileId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(Settings.selectedProfile.name, profileId);
    state = state.copyWith(selectedProfileId: profileId);
  }

  @override
  void setLanguage(Language language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Settings.language.name, language.locale.languageCode);
    state = state.copyWith(language: language);
  }
}
