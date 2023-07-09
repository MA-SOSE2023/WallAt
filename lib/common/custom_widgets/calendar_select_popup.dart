import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectCalendarPopup extends StatelessWidget {
  const SelectCalendarPopup({
    Key? key,
    required Function(Calendar) onCalendarSelected,
    Function()? onCancel,
  })  : _onCalendarSelected = onCalendarSelected,
        _onCancel = onCancel,
        super(key: key);

  final Function(Calendar) _onCalendarSelected;
  final Function()? _onCancel;

  @override
  Widget build(BuildContext context) {
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
          final calendars = snapshot.data!.data!;
          final usableCalendars =
              calendars.where((calendar) => !calendar.isReadOnly!).toList();

          return CupertinoAlertDialog(
            title: const Text('Select Calendar'),
            content: Column(
              children: [
                const Text('Select a calendar to add the event to:'),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: CupertinoDynamicColor.resolve(
                        CupertinoColors.systemGrey5, context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CupertinoListSection.insetGrouped(
                    header: const Text("Available Calendars"),
                    backgroundColor: Colors.transparent,
                    children: usableCalendars
                        .map(
                          (calendar) => CupertinoListTile(
                            backgroundColor: CupertinoDynamicColor.resolve(
                              CupertinoColors.systemBackground,
                              context,
                            ),
                            title: Text(calendar.name!),
                            onTap: () {
                              _onCalendarSelected(calendar);
                              Navigator.pop(context);
                            },
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
                  _onCancel?.call();
                },
              ),
            ],
          );
        }
      },
    );
  }
}
