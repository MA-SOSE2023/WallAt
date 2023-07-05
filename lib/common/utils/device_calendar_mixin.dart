import 'package:device_calendar/device_calendar.dart';

mixin DeviceCalendarMixin {
  Future<Result<String>?> addEventToCalendar(Event event) async {
    DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    return await deviceCalendarPlugin.createOrUpdateEvent(event);
  }

  Future<Result<bool>> removeEventFromCalendar(Event event) async {
    DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    return deviceCalendarPlugin.deleteEvent(event.calendarId, event.eventId);
  }

  Future<Calendar?> getCalendarById(String? id) async {
    if (id == null) {
      return null;
    }
    DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    Result<List<Calendar>> calendars =
        await deviceCalendarPlugin.retrieveCalendars();
    if (calendars.data == null) {
      return null;
    }
    List<Calendar> filteredCalendars = calendars.data!
        .where((c) => !(c.isReadOnly ?? true))
        .where(
          (c) => c.id == id,
        )
        .toList();
    if (filteredCalendars.isEmpty) {
      return null;
    }
    return filteredCalendars.first;
  }

  Event copyEventWithId(Event event, String? id) {
    return Event(
      event.calendarId,
      eventId: id,
      title: event.title,
      description: event.description,
      start: event.start,
      end: event.end,
      allDay: event.allDay,
      attendees: event.attendees,
      location: event.location,
      recurrenceRule: event.recurrenceRule,
      reminders: event.reminders,
      status: event.status,
      url: event.url,
    );
  }
}
