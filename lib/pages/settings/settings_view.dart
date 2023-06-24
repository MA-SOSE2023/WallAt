import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/common/provider.dart';
import 'settings_model.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsModel settings = ref.watch(Providers.settingsControllerProvider);
    SettingsController controller =
        ref.read(Providers.settingsControllerProvider.notifier);

    void setSystemCalendar(BuildContext context) {
      DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder<Result<List<Calendar>>>(
            future: deviceCalendarPlugin.retrieveCalendars(),
            builder: (BuildContext context,
                AsyncSnapshot<Result<List<Calendar>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CupertinoAlertDialog(
                  title: const Text('Loading'),
                  content: const CircularProgressIndicator(),
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
                          return Container(
                            decoration: BoxDecoration(
                              color: CupertinoDynamicColor.resolve(
                                  CupertinoColors.systemGrey5, context),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CupertinoListSection.insetGrouped(
                              header: const Text("Available Calendars"),
                              backgroundColor: Colors.transparent,
                              children: [
                                CupertinoListTile(
                                  backgroundColor:
                                      CupertinoDynamicColor.resolve(
                                          CupertinoColors.systemBackground,
                                          context),
                                  title: Text(calendar.name!),
                                  onTap: () {
                                    controller.setUsedCalendar(calendar);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
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
                  ],
                );
              }
            },
          );
        },
      );
    }

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Settings"),
        ),
        child: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoDynamicColor.resolve(
                        CupertinoColors.systemGrey5, context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CupertinoListSection.insetGrouped(
                      backgroundColor: Colors.transparent,
                      decoration: BoxDecoration(
                          color: CupertinoDynamicColor.resolve(
                              CupertinoColors.systemBackground, context)),
                      header: Text("Common"),
                      children: [
                        CupertinoListTile(
                            title: Text("Toggle Color Theme"),
                            trailing: CupertinoSwitch(
                                onChanged: (value) =>
                                    {controller.toggleColorTheme(value)},
                                value: controller.isDarkMode())),
                        CupertinoListTile(
                            title: const Text("Set a system calendar"),
                            subtitle: Text(
                              (settings.calendar == null)
                                  ? "No calendar selected"
                                  : "Selected calendar: ${settings.calendar!.name}\nwith id ${settings.calendar!.id}",
                              maxLines: 2,
                            ),
                            trailing: CupertinoButton(
                                child: const Icon(CupertinoIcons.add),
                                onPressed: () => {setSystemCalendar(context)}))
                      ]),
                ))));
  }
}

abstract class SettingsController extends StateNotifier<SettingsModel> {
  SettingsController(SettingsModel state) : super(state);

  bool isDarkMode() {
    return state.brightness == Brightness.dark;
  }

  void setUsedCalendar(Calendar calendar);

  void toggleColorTheme(bool value);
}
