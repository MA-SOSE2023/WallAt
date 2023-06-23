import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider.dart';
import '/pages/single_item/single_item_view.dart';

import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import '/pages/single_item/model/item_event.dart';

class CalendarButton extends ConsumerStatefulWidget {
  const CalendarButton({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  ConsumerState<CalendarButton> createState() => _CalendarButtonState();
}

class _CalendarButtonState extends ConsumerState<CalendarButton> {
  String? selectedCalendarId;
  String description = '';
  int selectedRecurrenceIndex = 0;
  Reminder selectedReminder = Reminder(minutes: 0);

  final Map<RecurrenceRule, String> recurrenceOptions = {
    RecurrenceRule(null): 'None',
    RecurrenceRule(RecurrenceFrequency.Daily): 'Daily',
    RecurrenceRule(RecurrenceFrequency.Weekly): 'Weekly',
    RecurrenceRule(RecurrenceFrequency.Monthly): 'Monthly',
    RecurrenceRule(RecurrenceFrequency.Yearly): 'Yearly',
  };

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: const Icon(CupertinoIcons.calendar_badge_plus),
      onPressed: () {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();

            return FutureBuilder<Result<List<Calendar>>?>(
              future: deviceCalendarPlugin.retrieveCalendars(),
              builder: (BuildContext context,
                  AsyncSnapshot<Result<List<Calendar>>?> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final calendars = snapshot.data!.data!;
                  final usableCalendars = calendars
                      .where((calendar) => !calendar.isReadOnly!)
                      .toList();

                  return CupertinoAlertDialog(
                    title: const Text('Select Calendar'),
                    content: Column(
                      children: [
                        Text('Select a calendar to add the event to:'),
                        SizedBox(height: 16),
                        Column(
                          children: usableCalendars.map((calendar) {
                            return CupertinoListSection(
                              children: [
                                CupertinoListTile(
                                  title: Text(calendar.name!),
                                  trailing: selectedCalendarId ==
                                          calendar.id.toString()
                                      ? const Icon(CupertinoIcons.check_mark)
                                      : null,
                                  onTap: () {
                                    setState(() {
                                      selectedCalendarId = calendar.id;
                                    });
                                  },
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text('Next'),
                        onPressed: () {
                          if (selectedCalendarId != null) {
                            Navigator.pop(context);
                            _showAddEventDialog(
                              context,
                              deviceCalendarPlugin,
                            );
                          }
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return CupertinoAlertDialog(
                    title: const Text('Error'),
                    content: Text('Failed to retrieve calendars.'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                } else {
                  return CupertinoAlertDialog(
                    title: const Text('Loading'),
                    content: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  void _showAddEventDialog(
    BuildContext context,
    DeviceCalendarPlugin deviceCalendarPlugin,
  ) {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().add(Duration(hours: 1));
    String title = 'Test Event';
    String description = '';

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return CupertinoAlertDialog(
              title: const Text('Add Event'),
              content: Column(
                children: [
                  CupertinoTextField(
                    placeholder: 'Event Title',
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  CupertinoTextField(
                    placeholder: 'Event Description',
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    placeholder: 'Enter reminder minutes',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        selectedReminder = Reminder(minutes: int.parse(value));
                      });
                    },
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly
                    // ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Recurrence'),
                  CupertinoSlidingSegmentedControl<int>(
                    groupValue: selectedRecurrenceIndex,
                    children: {
                      for (int i = 0; i < recurrenceOptions.length; i++)
                        i: Text(
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            recurrenceOptions.values.elementAt(i)),
                    },
                    onValueChanged: (int? value) {
                      setState(() {
                        selectedRecurrenceIndex = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Start Time:'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final selectedDateTime =
                                await showCupertinoModalPopup<DateTime>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: CupertinoColors.white,
                                  ),
                                  height: 216,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.dateAndTime,
                                    initialDateTime: startDate,
                                    onDateTimeChanged: (DateTime? dateTime) {
                                      if (dateTime != null) {
                                        setState(() {
                                          startDate = dateTime;
                                        });
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                            if (selectedDateTime != null) {
                              setState(() {
                                startDate = selectedDateTime;
                              });
                            }
                          },
                          child: Text(
                            formatDate(startDate),
                            style: const TextStyle(
                              color: CupertinoColors.systemBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('End Time:'),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final selectedDateTime =
                                await showCupertinoModalPopup<DateTime>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: CupertinoColors.white,
                                  ),
                                  height: 216,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.dateAndTime,
                                    initialDateTime: endDate,
                                    onDateTimeChanged: (DateTime? dateTime) {
                                      if (dateTime != null) {
                                        setState(() {
                                          endDate = dateTime;
                                        });
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                            if (selectedDateTime != null) {
                              setState(() {
                                endDate = selectedDateTime;
                              });
                            }
                          },
                          child: Text(
                            formatDate(endDate),
                            style: const TextStyle(
                              color: CupertinoColors.systemBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('Add Event'),
                  onPressed: () async {
                    final local = tz.local; // Get local time zone
                    // Retrieve the selected recurrence and notification values
                    RecurrenceRule? selectedRecurrence;
                    if (selectedRecurrenceIndex != 0) {
                      selectedRecurrence = recurrenceOptions.keys
                          .elementAt(selectedRecurrenceIndex);
                    }

                    final Event newEvent = Event(selectedCalendarId!,
                        eventId: null,
                        start: tz.TZDateTime.from(startDate, local),
                        end: tz.TZDateTime.from(endDate, local),
                        title: title,
                        description: description,
                        recurrenceRule: selectedRecurrence,
                        reminders: [selectedReminder]);
                    var result = await deviceCalendarPlugin
                        .createOrUpdateEvent(newEvent);
                    newEvent.eventId = result?.data!;

                    ref
                        .read(Providers.editSingleItemControllerProvider(
                                widget.id)
                            .notifier)
                        .addEvent(
                            ItemEvent(event: newEvent, parentId: widget.id));

                    Navigator.pop(context);
                    // Event added successfully
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  String formatDate(DateTime dateTime) {
    final timeFormat = DateFormat.jm();
    final dateFormat = DateFormat.yMMMMd();
    final formattedTime = timeFormat.format(dateTime);
    final formattedDate = dateFormat.format(dateTime);
    return '$formattedDate, $formattedTime';
  }
}
