import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart' show SelectionDialog;

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

          return SelectionDialog(
            selectables: usableCalendars,
            title: "Select a Calendar",
            header: "Available Calendars",
            onTapped: (calendar) => onCalendarSelected(calendar),
            builder: (calendar) => Text(calendar.name ?? '<no name>'),
            isSelected: (calendar) => calendar.id == selectedCalendarId,
          );
        }
      },
    );
  }
}
