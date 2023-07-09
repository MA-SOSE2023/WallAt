import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';

import 'language.dart';

class LanguageEn extends Language {
  const LanguageEn() : super(locale: const Locale('en'), name: 'English');

  @override
  String formatDateTime(TZDateTime date) =>
      DateFormat('MM/dd/yyyy  -  HH:mm').format(date);

  // Page titles
  @override
  String get titleHome => "Home";
  @override
  String get titleProfile => "Profiles";
  @override
  String get titleFolders => "Folders";
  @override
  String get titleSettings => "Settings";
  @override
  String get titleFavorites => "Favorites";

  // Home page
  @override
  String get lblFrequentlyUsed => "Frequently used";
  @override
  String get errLoadRecentItems =>
      'Something went wrong while loading your recent items.\nTry restarting the app.';

  // Bottom navigation bar
  @override
  String get lblHome => "Home";
  @override
  String get lblFavorites => "Favorites";
  @override
  String get lblFolders => "Folders";
  @override
  String get lblCamera => "Camera";
  @override
  String get lblSettings => "Settings";

  // Profile page
  @override
  String get lblProfiles => "Profiles";
  @override
  String get lblProfileIsSelected => "Currently selected";
  @override
  String get lblGlobalProfileIsSelected => "Currently using global view";
  @override
  String get lblAddProfile => "Add profile";
  @override
  String get txtProfileName => "Profile name";
  @override
  String get btnSelectProfile => "Select this profile";
  @override
  String get btnGlobalProfile => "Switch to global view";
  @override
  String get infoNoProfiles =>
      'Profiles are a way to categorize your data in a broad way.\n'
      'Each profile will have different data.\n\n'
      'Try creating one by tapping the  +  above';
  @override
  String get nameProfile => "Profile";

  // Folders page
  @override
  String get lblSubfolders => "Subfolders";
  @override
  String get lblAddFolder => "Add Subfolder";
  @override
  String get txtFolderTitle => "Folder title";
  @override
  String get infoFolderEmpty => "This folder is empty.\nTry adding some items.";
  @override
  String get nameFolder => "Folder";
  @override
  String get errNullFolder =>
      'No matching folder was found.\nTry restarting the app.';
  @override
  String get errLoadFolder =>
      'Something went wrong while loading the folder.\nTry restarting the app.';

  // Favorites page
  @override
  String get infoFavoritesEmpty =>
      "No favorites yet.\nTry adding some by tapping the heart icon.";
  @override
  String get errLoadFavorites =>
      'Something went wrong while loading your favorites.\nTry restarting the app.';

  // Settings page
  @override
  String get lblThemeSetting => "Custom Theme";
  @override
  String get lblCurrentTheme => "Current Theme";
  @override
  String get lblSelectTheme => "Select a Theme";
  @override
  String get lblLanguageSetting => "Language";
  @override
  String get lblSelectLanguage => "Select a Language";
  @override
  String get lblCurrentLanguage => "Current Language";
  @override
  String get lblCalendarSetting => "System Calendar";
  @override
  String get lblCurrentCalendar => "Selected Calendar";
  @override
  String get lblNoCurrentCalendar => "No calendar selected";
  @override
  String get lblAvailableCalendars => "Available Calendars";
  @override
  String get lblSelectCalendar => "Select a Calendar";
  @override
  String get lblProfileSetting => "User Profile";
  @override
  String get lblCurrentProfile => "Current Profile";
  @override
  String get lblSelectProfile => "Select a Profile";

  // Themes
  @override
  String get lblLightTheme => "Light";
  @override
  String get lblDarkTheme => "Dark";
  @override
  String get lblOceanTheme => "Ocean";
  @override
  String get lblHotDogStandTheme => "Hot Dog Stand";

  // Items
  @override
  String get titleEditItem => "Edit Item";
  @override
  String get txtDescription => "Description";
  @override
  String get txtTitle => "Title";
  @override
  String get infoNoItemsYet =>
      "No items yet.\nTry adding some by clicking the camera button.";
  @override
  String get errLoadItem => "Item could not be loaded.";

  // Events
  @override
  String get titleEvents => "Events";
  @override
  String get lblNoEvents => "No events";
  @override
  String get infoNoEventsYet => "Events that are neary due will appear here.\n"
      "Try adding some from the detail page of an item.";
  @override
  String get lblAddEvent => "Add Event";
  @override
  String get txtEventTitle => "Event Title";
  @override
  String get txtEventDescription => "Event Description";
  @override
  String get txtReminderMinutes => "Enter reminder minutes";
  @override
  String get lblRecurrence => "Recurrence";
  @override
  String get lblRecurrenceNever => "Never";
  @override
  String get lblRecurrenceDaily => "Daily";
  @override
  String get lblRecurrenceWeekly => "Weekly";
  @override
  String get lblRecurrenceMonthly => "Monthly";
  @override
  String get lblRecurrenceYearly => "Yearly";
  @override
  String get lblEventStart => "Start Time";
  @override
  String get lblEventEnd => "End Time";
  @override
  String get lblEventFrom => "From";
  @override
  String get lblEventTo => "To";
  @override
  String get btnAddEvent => "Add Event";

  // Generic
  @override
  String get lblCancel => "Cancel";
  @override
  String get lblSave => "Save";
  @override
  String get lblDelete => "Delete";
  @override
  String get lblLoading => "Loading";
  @override
  String get lblEdit => "Edit";
  @override
  String get lblAdd => "Add";
  @override
  String get lblError => "Error";
  @override
  String get infoNoItemsFoundForFilter => "No items found for";
  @override
  String get infoGenericEmpty => "There are no entries yet.\nTry adding some.";
  @override
  String get txtSearch => "Search";

  // Errors
  @override
  String get errLoadCalendar => "Failed to load calendars";
  @override
  String get errLoadEvents =>
      "Failed to load events.\nTry re-opening this page.";
  @override
  String get errGenericLoad => "Something went wrong.\nPlease try again.";
  @override
  String get errApplyFilter => "Filter could not be applied.";
}
