import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';

import 'language.dart';

class LanguageDe extends Language {
  const LanguageDe() : super(locale: const Locale('de'), name: 'Deutsch');

  @override
  String formatDateTime(TZDateTime date) =>
      DateFormat('dd.MM.yyyy  -  HH:mm').format(date);

  // Page titles
  @override
  String get titleHome => "Startseite";
  @override
  String get titleProfile => "Profile";
  @override
  String get titleFolders => "Ordner";
  @override
  String get titleSettings => "Einstellungen";
  @override
  String get titleFavorites => "Favoriten";

  // Home page
  @override
  String get lblFrequentlyUsed => "Häufig verwendet";
  @override
  String get errLoadRecentItems =>
      'Beim Laden der Dokumente ist etwas schiefgelaufen.\nVersuchen Sie die App neu zu starten.';

  // Bottom navigation bar
  @override
  String get lblHome => "Startseite";
  @override
  String get lblFavorites => "Favoriten";
  @override
  String get lblFolders => "Ordner";
  @override
  String get lblCamera => "Kamera";
  @override
  String get lblSettings => "Einstellungen";

  // Profile page
  @override
  String get lblProfiles => "Profile";
  @override
  String get lblProfileIsSelected => "Aktuell ausgewählt";
  @override
  String get lblGlobalProfileIsSelected => "Aktuell auf globaler Ansicht";
  @override
  String get lblAddProfile => "Profil hinzufügen";
  @override
  String get txtProfileName => "Profilname";
  @override
  String get btnSelectProfile => "Dieses Profil wählen";
  @override
  String get btnGlobalProfile => "Zu globaler Ansicht wechseln";
  @override
  String get infoNoProfiles =>
      'Profile sind eine Möglichkeit Ihre Daten breiter zu kategorisieren\n'
      'Jedes Profil verfügt über seperate Daten.\n'
      'Fügen Sie welche hinzu, indem Sie auf das Plus-Symbol tippen.';
  @override
  String get nameProfile => "Profil";

  // Folders page
  @override
  String get lblSubfolders => "Unterordner";
  @override
  String get lblAddFolder => "Unterordner hinzufügen";
  @override
  String get txtFolderTitle => "Ordnername";
  @override
  String get infoFolderEmpty =>
      "Dieser Ordner ist leer.\nVersuche Sie einige Elemente hinzuzufügen.";
  @override
  String get nameFolder => "Ordner";
  @override
  String get errNullFolder =>
      'Es konnte kein Ordner gefunden werde.\nVersuchen Sie die App neu zu starten.';
  @override
  String get errLoadFolder =>
      'Beim Laden des Ordners ist etwas schiefgelaufen.\nVersuchen Sie die App neu zu starten.';

  // Favorites page
  @override
  String get infoFavoritesEmpty =>
      "Sie haben noch keine Favoriten.\nFügen Sie welche hinzu, indem Sie auf das Herzsymbol tippen.";
  @override
  String get errLoadFavorites =>
      "Fehler beim Laden der Favoriten.\nVersuchen sie die App neu zu starten.";

  // Settings page
  @override
  String get lblThemeSetting => "Farbwahl";
  @override
  String get lblCurrentTheme => "Aktuelle Farbwahl";
  @override
  String get lblSelectTheme => "Farbwahl ändern";
  @override
  String get lblLanguageSetting => "Sprache";
  @override
  String get lblSelectLanguage => "Sprache auswählen";
  @override
  String get lblCurrentLanguage => "Aktuelle Sprache";
  @override
  String get lblCalendarSetting => "Kalender";
  @override
  String get lblCurrentCalendar => "Ausgewählter Kalender";
  @override
  String get lblNoCurrentCalendar => "Kein Kalender ausgewählt";
  @override
  String get lblAvailableCalendars => "Verfügbare Kalender";
  @override
  String get lblSelectCalendar => "Kalender ändern";
  @override
  String get lblProfileSetting => "Profil";
  @override
  String get lblCurrentProfile => "Aktuelles Profil";
  @override
  String get lblSelectProfile => "Profil ändern";

  // Themes
  @override
  String get lblLightTheme => "Hell";
  @override
  String get lblDarkTheme => "Dunkel";
  @override
  String get lblOceanTheme => "Ozean";
  @override
  String get lblHotDogStandTheme => "Hot Dog Stand";

  // Items
  @override
  String get titleEditItem => "Dokument bearbeiten";
  @override
  String get txtDescription => "Beschreibung";
  @override
  String get txtTitle => "Titel";
  @override
  String get infoNoItemsYet =>
      "Keine Elemente vorhanden.\nFügen Sie welche hinzu, indem Sie auf das Kamera-Symbol tippen.";
  @override
  String get errLoadItem => "Dokument konnte nicht geladen werden.";

  // Events
  @override
  String get titleEvents => "Termine";
  @override
  String get lblNoEvents => "Keine Termine";
  @override
  String get infoNoEventsYet =>
      "Termine, die kurz bevorstehen, werden hier angezeigt.\nFügen Sie welche von der Detailansicht eines Dokuments hinzu.";
  @override
  String get lblAddEvent => "Termin hinzufügen";
  @override
  String get txtEventTitle => "Titel";
  @override
  String get txtEventDescription => "Beschreibung";
  @override
  String get txtReminderMinutes => "Vorher benachrichtigt werden [Minuten]";
  @override
  String get lblRecurrence => "Wiederholung";
  @override
  String get lblRecurrenceNever => "Nie";
  @override
  String get lblRecurrenceDaily => "Täglich";
  @override
  String get lblRecurrenceWeekly => "Wöchentlich";
  @override
  String get lblRecurrenceMonthly => "Monatlich";
  @override
  String get lblRecurrenceYearly => "Jährlich";
  @override
  String get lblEventStart => "Beginn";
  @override
  String get lblEventEnd => "Ende";
  @override
  String get lblEventFrom => "Von";
  @override
  String get lblEventTo => "Bis";
  @override
  String get btnAddEvent => "Hinzufügen";

  // Generic
  @override
  String get lblCancel => "Abbrechen";
  @override
  String get lblSave => "Speichern";
  @override
  String get lblDelete => "Löschen";
  @override
  String get lblLoading => "Lädt";
  @override
  String get lblEdit => "Bearbeiten";
  @override
  String get lblAdd => "Hinzufügen";
  @override
  String get lblError => "Fehler";
  @override
  String get infoNoItemsFoundForFilter => "Keine Elemente mit Namen";
  @override
  String get infoGenericEmpty =>
      "Keine Elemente vorhanden.\nFügen Sie welche hinzu.";
  @override
  String get txtSearch => "Suchen";

  // Errors
  @override
  String get errLoadCalendar => "Fehler beim Laden der Kalender";
  @override
  String get errLoadEvents =>
      "Termine konnten nicht geladen werden.\nVersuchen Sie die Seite neu zu laden";
  @override
  String get errGenericLoad =>
      "Etwas ist schief gelaufen.\nVersuchen Sie es erneut";
  @override
  String get errApplyFilter => "Filter konnte nicht angewendet werden.";
}
