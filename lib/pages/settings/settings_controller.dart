import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:gruppe4/pages/profiles/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_model.dart';
import 'settings_view.dart';
import '/common/utils/device_calendar_mixin.dart';

enum Settings {
  calendar,
  selectedColorTheme,
  selectedProfile,
  availableProfileNames,
  availableProfilePictures,
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
    prefs.setInt(Settings.selectedColorTheme.name, index);
    state = state.copyWith(selectedThemeIndex: index);
  }

  @override
  void createProfile(ProfileModel profile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> profiles =
        prefs.getStringList(Settings.availableProfileNames.name) ?? [];
    prefs.setStringList(
        Settings.availableProfileNames.name, [...profiles, profile.name]);
    final List<String> profilePictures =
        prefs.getStringList(Settings.availableProfilePictures.name) ?? [];
    prefs.setStringList(Settings.availableProfilePictures.name,
        [...profilePictures, (profile.profilePicture as AssetImage).assetName]);
  }

  @override
  Future<List<ProfileModel>> getAvailableProfies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> profileNames =
        prefs.getStringList(Settings.availableProfileNames.name) ?? [];
    final List<ImageProvider> profilePictures =
        (prefs.getStringList(Settings.availableProfilePictures.name) ?? [])
            .map((path) => AssetImage(path))
            .toList();
    return List.generate(
      profileNames.length,
      (index) => ProfileModel(
        id: profileNames[index],
        name: profileNames[index],
        profilePicture: profilePictures[index],
      ),
    );
  }

  @override
  void setProfileIndex(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(Settings.selectedProfile.name, index);
    state = state.copyWith(selectedProfileIndex: index);
  }

  @override
  void deleteProfile(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> profileNames =
        prefs.getStringList(Settings.availableProfileNames.name) ?? [];
    final List<String> profilePictures =
        prefs.getStringList(Settings.availableProfilePictures.name) ?? [];
    prefs.setStringList(
      Settings.availableProfileNames.name,
      [...profileNames.take(index), ...profileNames.skip(index + 1)],
    );
    prefs.setStringList(
      Settings.availableProfilePictures.name,
      [...profilePictures.take(index), ...profilePictures.skip(index + 1)],
    );
    if (index == state.selectedProfileIndex) {
      final int newSelectedIndex =
          (state.selectedProfileIndex + 1) % (profileNames.length - 1);
      prefs.setInt(Settings.selectedProfile.name, newSelectedIndex);
      state = state.copyWith(selectedProfileIndex: newSelectedIndex);
    }
  }
}
