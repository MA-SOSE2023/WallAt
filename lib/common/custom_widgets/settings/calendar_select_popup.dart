import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/localization/language.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart' show SelectionDialog;

class SelectCalendarPopup extends ConsumerWidget {
  const SelectCalendarPopup({
    Key? key,
    required Function(Calendar) onCalendarSelected,
  })  : _onCalendarSelected = onCalendarSelected,
        super(key: key);

  final Function(Calendar) _onCalendarSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? selectedCalendarId =
        ref.watch(Providers.settingsControllerProvider).calendar?.id;
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;
    return FutureBuilder<Result<List<Calendar>>>(
      future: DeviceCalendarPlugin().retrieveCalendars(),
      builder: (BuildContext context,
          AsyncSnapshot<Result<List<Calendar>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CupertinoAlertDialog(
            title: Text(language.lblLoading),
            content: const CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return CupertinoAlertDialog(
            title: Text(language.lblError),
            content: Text(language.errLoadCalendar),
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
            title: language.lblSelectCalendar,
            header: language.lblAvailableCalendars,
            onTapped: (calendar) => _onCalendarSelected(calendar),
            builder: (calendar) => Text(calendar.name ?? '¯\\_(ツ)_/¯'),
            isSelected: (calendar) => calendar.id == selectedCalendarId,
          );
        }
      },
    );
  }
}
