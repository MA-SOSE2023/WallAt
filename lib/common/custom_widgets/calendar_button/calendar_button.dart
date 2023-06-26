import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/common/custom_widgets/calendar_button/calendar_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider.dart';

import '/common/custom_widgets/all_custom_widgets.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import '/pages/single_item/model/item_event.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({required this.id, Key? key}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        void _showAddEventDialog(
          BuildContext context,
        ) {
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                CalendarModel calendarModel =
                    ref.watch(Providers.calendarButtonControllerProvider);
                CalendarButtonController calendarButtonController = ref
                    .read(Providers.calendarButtonControllerProvider.notifier);
                return CupertinoAlertDialog(
                  title: const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text('Add Event'),
                  ),
                  content: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CupertinoTextField(
                          placeholder: 'Event Title',
                          onChanged: (value) {
                            calendarButtonController.setTitle(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CupertinoTextField(
                          placeholder: 'Event Description',
                          onChanged: (value) {
                            calendarButtonController.setDescription(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CupertinoTextField(
                          placeholder: 'Enter reminder minutes',
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            calendarButtonController
                                .setReminderMinutes(int.parse(value));
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      const Text('Recurrence'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CupertinoSlidingSegmentedControl<int>(
                          groupValue: calendarModel.selectedRecurrenceIndex,
                          children: {
                            for (int i = 0; i < recurrenceOptions.length; i++)
                              i: Text(
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                  recurrenceOptions.values.elementAt(i)),
                          },
                          onValueChanged: (int? value) {
                            calendarButtonController
                                .setRecurrenceIndex(value ?? 0);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: DatePicker(
                          description: "Start Time",
                          dateTime: calendarModel.startDate!,
                          onDateTimeChanged:
                              calendarButtonController.setStartDate,
                        ),
                      ),
                      DatePicker(
                        description: "End Time",
                        dateTime: calendarModel.endDate!,
                        onDateTimeChanged: calendarButtonController.setEndDate,
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
                        final Event newEvent =
                            calendarButtonController.getEvent();
                        ref
                            .read(Providers.editSingleItemControllerProvider(id)
                                .notifier)
                            .addEvent(event: newEvent, parentId: id);

                        Navigator.pop(context);
                        // Event added successfully
                      },
                    ),
                  ],
                );
              });
            },
          );
        }

        return CupertinoButton(
          child: const Icon(CupertinoIcons.calendar_badge_plus),
          onPressed: () {
            _showAddEventDialog(context);
          },
        );
      },
    );
  }
}

String formatDate(DateTime dateTime) {
  final timeFormat = DateFormat.jm();
  final dateFormat = DateFormat.yMMMMd();
  final formattedTime = timeFormat.format(dateTime);
  final formattedDate = dateFormat.format(dateTime);
  return '$formattedDate, $formattedTime';
}

abstract class CalendarButtonController extends StateNotifier<CalendarModel> {
  CalendarButtonController(CalendarModel state) : super(state);

  void setTitle(String title);

  void setDescription(String description);

  void setStartDate(DateTime? date);

  void setEndDate(DateTime? date);

  void setRecurrenceIndex(int index);

  void setReminderMinutes(int minutes);

  String getTitle();

  String getDescription();

  DateTime? getStartDate();

  DateTime? getEndDate();

  int getRecurrenceIndex();

  int getReminderMinutes();

  Event getEvent();
}
