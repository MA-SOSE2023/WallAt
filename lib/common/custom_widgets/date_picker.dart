import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/custom_widgets/all_custom_widgets.dart';
import 'package:gruppe4/common/theme/custom_theme_data.dart';

import '../provider.dart';

class DatePicker extends ConsumerWidget {
  const DatePicker(
      {required String description,
      required DateTime dateTime,
      required Function(DateTime) onDateTimeChanged,
      super.key})
      : _description = description,
        _dateTime = dateTime,
        _onDateTimeChanged = onDateTimeChanged;

  final String _description;
  final DateTime _dateTime;
  final void Function(DateTime) _onDateTimeChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomThemeData theme = ref.read(Providers.themeControllerProvider);
    return Row(
      children: [
        Text('$_description:'),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showCupertinoModalPopup<DateTime>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                    ),
                    height: 216,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: _dateTime,
                      onDateTimeChanged: (DateTime? dateTime) {
                        if (dateTime != null) {
                          return _onDateTimeChanged(dateTime);
                        }
                      },
                    ),
                  );
                },
              );
            },
            child: Text(
              formatDate(_dateTime),
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
