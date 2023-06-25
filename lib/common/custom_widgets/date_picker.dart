import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/custom_widgets/all_custom_widgets.dart';

class DatePicker extends ConsumerWidget {
  const DatePicker(
      {required this.description,
      required this.dateTime,
      required this.onDateTimeChanged});

  final String description;
  final DateTime dateTime;
  final void Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Text('Start Time:'),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showCupertinoModalPopup<DateTime>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                        color: CupertinoDynamicColor.resolve(
                            CupertinoColors.systemBackground, context)),
                    height: 216,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: dateTime,
                      onDateTimeChanged: (DateTime? dateTime) {
                        if (dateTime != null) {
                          return onDateTimeChanged(dateTime);
                        }
                      },
                    ),
                  );
                },
              );
            },
            child: Text(
              formatDate(dateTime),
              style: const TextStyle(
                color: CupertinoColors.systemBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
