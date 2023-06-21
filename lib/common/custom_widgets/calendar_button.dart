import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/provider.dart';
import '/pages/single_item/model/item_event.dart';

class CalendarButton extends ConsumerStatefulWidget {
  const CalendarButton({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  ConsumerState<CalendarButton> createState() => _CalendarButtonState();
}

class _CalendarButtonState extends ConsumerState<CalendarButton> {
  String description = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: const Icon(CupertinoIcons.calendar_badge_plus),
      onPressed: () => showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final DateTime? currentDate = ref
                .watch(Providers.editSingleItemControllerProvider(widget.id))
                .currentSelectedDate;
            return CupertinoAlertDialog(
              title: const Text('Select Date'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 216,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: Colors.white),
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                minimumDate: DateTime(1900),
                                maximumDate: DateTime(2100),
                                onDateTimeChanged: (DateTime? dateTime) {
                                  ref
                                      .read(Providers
                                              .editSingleItemControllerProvider(
                                                  widget.id)
                                          .notifier)
                                      .setCurrentDate(dateTime!);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(currentDate != null
                        ? '${currentDate.day}/${currentDate.month}/${currentDate.year}'
                        : 'Select Date'),
                  ),
                  const SizedBox(height: 20),
                  CupertinoTextField(
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                ],
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    // Do something with the selected date and description
                    if (currentDate != null && description.isNotEmpty) {
                      // Use the selected date and description as needed
                      ItemEvent newEvent = ItemEvent(
                        date: currentDate,
                        description: description,
                      );

                      ref
                          .read(Providers.editSingleItemControllerProvider(
                                  widget.id)
                              .notifier)
                          .addEvent(newEvent);
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          });
        },
      ),
    );
  }
}
