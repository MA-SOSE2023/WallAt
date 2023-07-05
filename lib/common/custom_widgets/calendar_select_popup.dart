import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';

class SelectCalendarPopup extends ConsumerWidget {
  const SelectCalendarPopup({
    Key? key,
    required this.onCalendarSelected,
    this.onCancel,
  }) : super(key: key);

  final Function(Calendar) onCalendarSelected;
  final Function()? onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    final String? selectedCalendarId =
        ref.watch(Providers.settingsControllerProvider).calendar?.id;
    return FutureBuilder<Result<List<Calendar>>>(
      future: DeviceCalendarPlugin().retrieveCalendars(),
      builder: (BuildContext context,
          AsyncSnapshot<Result<List<Calendar>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoAlertDialog(
            title: Text('Loading'),
            content: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return CupertinoAlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to retrieve calendars.'),
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
          final calendars = snapshot.data?.data;
          final usableCalendars = calendars == null
              ? []
              : calendars
                  .where((calendar) => !(calendar.isReadOnly ?? true))
                  .toList();

          return CupertinoAlertDialog(
            title: const Text('Select Calendar'),
            content: Column(
              children: [
                const Text('Select a calendar to add the event to:'),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: theme.groupingColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CupertinoListSection.insetGrouped(
                    header: const Text("Available Calendars"),
                    backgroundColor: Colors.transparent,
                    margin: const EdgeInsets.fromLTRB(12, 16, 8, 16),
                    children: usableCalendars
                        .map(
                          (calendar) => CupertinoListTile(
                            backgroundColor: theme.backgroundColor,
                            title: Text(calendar.name ?? '<no name>'),
                            onTap: () {
                              onCalendarSelected(calendar);
                              Navigator.pop(context);
                            },
                            leadingSize: 20,
                            leadingToTitle: 5,
                            leading: calendar.id == selectedCalendarId
                                ? Icon(
                                    CupertinoIcons.check_mark,
                                    color: theme.accentColor,
                                    size: 20,
                                  )
                                : null,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                  onCancel?.call();
                },
              ),
            ],
          );
        }
      },
    );
  }
}
