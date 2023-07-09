import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';

import 'language_de.dart';
import 'language_en.dart';

abstract class Language {
  const Language({required this.locale, required this.name});
  static Language of(String languageCode) {
    switch (languageCode) {
      case 'en':
        return en;
      case 'de':
        return de;
      default:
        return en;
    }
  }

  final String name;
  final Locale locale;

  @override
  String toString() => name;

  static List<Locale> get supportedLocales =>
      const [Locale('en', 'US'), Locale('de', 'DE')];

  static const Language en = LanguageEn();
  static const Language de = LanguageDe();

  String formatDateTime(TZDateTime date);

  // Page titles
  String get titleHome;
  String get titleProfile;
  String get titleFolders;
  String get titleSettings;
  String get titleFavorites;

  // Home page
  String get lblFrequentlyUsed;
  String get errLoadRecentItems;

  // Bottom navigation bar
  String get lblHome;
  String get lblFavorites;
  String get lblFolders;
  String get lblCamera;
  String get lblSettings;

  // Profile page
  String get lblProfiles;
  String get lblProfileIsSelected;
  String get lblGlobalProfileIsSelected;
  String get lblAddProfile;
  String get txtProfileName;
  String get btnSelectProfile;
  String get btnGlobalProfile;
  String get infoNoProfiles;
  String get nameProfile;

  // Folders page
  String get lblSubfolders;
  String get lblAddFolder;
  String get txtFolderTitle;
  String get infoFolderEmpty;
  String get nameFolder;
  String get errNullFolder;
  String get errLoadFolder;

  // Favorites page
  String get infoFavoritesEmpty;
  String get errLoadFavorites;

  // Settings page
  String get lblThemeSetting;
  String get lblCurrentTheme;
  String get lblSelectTheme;
  String get lblLanguageSetting;
  String get lblSelectLanguage;
  String get lblCurrentLanguage;
  String get lblCalendarSetting;
  String get lblCurrentCalendar;
  String get lblNoCurrentCalendar;
  String get lblSelectCalendar;
  String get lblAvailableCalendars;
  String get lblProfileSetting;
  String get lblCurrentProfile;
  String get lblSelectProfile;

  // Themes
  String get lblLightTheme;
  String get lblDarkTheme;
  String get lblOceanTheme;
  String get lblHotDogStandTheme;

  // Items
  String get titleEditItem;
  String get txtDescription;
  String get txtTitle;
  String get infoNoItemsYet;
  String get errLoadItem;

  // Events
  String get titleEvents;
  String get lblNoEvents;
  String get infoNoEventsYet;
  String get lblAddEvent;
  String get txtEventTitle;
  String get txtEventDescription;
  String get txtReminderMinutes;
  String get lblRecurrence;
  String get lblRecurrenceNever;
  String get lblRecurrenceDaily;
  String get lblRecurrenceWeekly;
  String get lblRecurrenceMonthly;
  String get lblRecurrenceYearly;
  String get lblEventStart;
  String get lblEventEnd;
  String get lblEventFrom;
  String get lblEventTo;
  String get btnAddEvent;

  // Generic
  String get lblCancel;
  String get lblSave;
  String get lblDelete;
  String get lblEdit;
  String get lblAdd;
  String get txtSearch;
  String get lblError;
  String get lblLoading;
  String get infoNoItemsFoundForFilter;
  String get infoGenericEmpty;

  // Errors
  String get errLoadCalendar;
  String get errLoadEvents;
  String get errGenericLoad;
  String get errApplyFilter;
}
