import 'package:device_calendar/device_calendar.dart';

import '/pages/single_item/model/item_event.dart';
import '/common/custom_widgets/calendar_button/calendar_model.dart';
import '/common/custom_widgets/calendar_button/calendar_button.dart';
import 'package:timezone/data/latest.dart' as tz;

var calendarModelMock = CalendarModel(
  title: 'title',
  description: 'description',
  startDate: DateTime.now(),
  endDate: DateTime.now(),
  selectedRecurrenceIndex: 0,
  selectedReminderMinutes: 0,
);

class CalendarButtonControllerImpl extends CalendarButtonController {
  CalendarButtonControllerImpl({CalendarModel? model})
      : super(model ?? calendarModelMock);

  @override
  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  @override
  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  @override
  void setStartDate(DateTime? date) {
    state = state.copyWith(startDate: date);
  }

  @override
  void setEndDate(DateTime? date) {
    state = state.copyWith(endDate: date);
  }

  @override
  void setRecurrenceIndex(int index) {
    state = state.copyWith(selectedRecurrenceIndex: index);
  }

  @override
  void setReminderMinutes(int minutes) {
    state = state.copyWith(selectedReminderMinutes: minutes);
  }

  @override
  String getTitle() {
    return state.title;
  }

  @override
  String getDescription() {
    return state.description;
  }

  @override
  DateTime? getStartDate() {
    return state.startDate;
  }

  @override
  DateTime? getEndDate() {
    return state.endDate;
  }

  @override
  int getRecurrenceIndex() {
    return state.selectedRecurrenceIndex;
  }

  @override
  int getReminderMinutes() {
    return state.selectedReminderMinutes;
  }

  @override
  Event getEvent() {
    return Event(
      '5', //@TODO: change to get from the settings controller
      eventId: null,
      title: getTitle(),
      description: getDescription(),
      start: TZDateTime.from(getStartDate()!, local),
      end: TZDateTime.from(getEndDate()!, local),
      recurrenceRule: recurrenceOptions.keys.elementAt(getRecurrenceIndex()),
      reminders: [
        Reminder(minutes: getReminderMinutes()),
      ],
    );
  }
}
