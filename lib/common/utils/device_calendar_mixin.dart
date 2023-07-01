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
