import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'calendar_model.dart';

import '/pages/settings/settings_model.dart';
import '/pages/settings/settings_view.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show DatePicker, SelectCalendarPopup;
import '/common/provider.dart';

class CalendarButton extends ConsumerWidget {
  const CalendarButton({required Function(Event event) onSave, Key? key})
      : _onSave = onSave,
        super(key: key);

  final Function(Event event) _onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsController controller =
        ref.read(Providers.settingsControllerProvider.notifier);
    void showAddEventDialog(
      BuildContext context,
    ) {
      final settings = ref.watch(Providers.settingsControllerProvider);
      final language = settings.language;

      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              CalendarModel calendarModel =
                  ref.watch(Providers.calendarButtonControllerProvider);
              CalendarButtonController calendarButtonController =
                  ref.read(Providers.calendarButtonControllerProvider.notifier);
              return CupertinoAlertDialog(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(language.lblAddEvent),
                ),
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CupertinoTextField(
                        placeholder: language.txtEventTitle,
                        onChanged: (value) {
                          calendarButtonController.setTitle(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CupertinoTextField(
                        placeholder: language.txtEventDescription,
                        onChanged: (value) {
                          calendarButtonController.setDescription(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CupertinoTextField(
                        placeholder: language.txtReminderMinutes,
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
                    Text(language.lblRecurrence),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CupertinoSlidingSegmentedControl<int>(
                        groupValue: calendarModel.selectedRecurrenceIndex,
                        children: {
                          for (int i = 0;
                              i < recurrenceOptions(language).length;
                              i++)
                            i: Text(
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                                maxLines: 1,
                                recurrenceOptions(language)
                                    .values
                                    .elementAt(i)),
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
                        description: language.lblEventStart,
                        dateTime: calendarModel.startDate!,
                        onDateTimeChanged:
                            calendarButtonController.setStartDate,
                      ),
                    ),
                    DatePicker(
                      description: language.lblEventEnd,
                      dateTime: calendarModel.endDate!,
                      onDateTimeChanged: calendarButtonController.setEndDate,
                    ),
                  ],
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(language.lblCancel),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(language.lblAddEvent),
                    onPressed: () async {
                      SettingsModel settings =
                          ref.watch(Providers.settingsControllerProvider);

                      final Event newEvent = calendarButtonController
                          .getEvent(settings.calendar?.id);
                      _onSave(newEvent);

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

      // Display calendar selection on top of the dialog
      if (settings.calendar == null) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return SelectCalendarPopup(
              onCalendarSelected: (calendar) {
                controller.setUsedCalendar(calendar);
              },
            );
          },
        );
      }
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: const Icon(CupertinoIcons.calendar_badge_plus),
      onPressed: () {
        showAddEventDialog(context);
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

  Event getEvent(String? calendarId);
}
