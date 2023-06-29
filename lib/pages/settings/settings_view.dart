import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_model.dart';
import '/common/custom_widgets/all_custom_widgets.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsModel settings = ref.watch(Providers.settingsControllerProvider);
    SettingsController controller =
        ref.read(Providers.settingsControllerProvider.notifier);

    CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    void setSystemCalendar(BuildContext context) {
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

    return CupertinoPageScaffold(
      backgroundColor: theme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: theme.navBarColor,
        middle: const Text("Settings"),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: theme.groupingColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CupertinoListSection.insetGrouped(
              backgroundColor: Colors.transparent,
              decoration: BoxDecoration(
                color: theme.backgroundColor,
              ),
              header: const Text("Common"),
              children: [
                CupertinoListTile(
                  title: const Text("Set a preferred color theme"),
                  subtitle: Text(
                    "Selected Theme: ${ref.watch(Providers.themeControllerProvider).name}",
                  ),
                  trailing: CupertinoButton(
                    child: const Icon(CupertinoIcons.add),
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: const Text('Select a theme'),
                            content: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: theme.groupingColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CupertinoListSection.insetGrouped(
                                    backgroundColor: Colors.transparent,
                                    decoration: BoxDecoration(
                                      color: theme.backgroundColor,
                                    ),
                                    header: const Text("Themes"),
                                    children: selectableThemes.map((currTheme) {
                                      return CupertinoListTile(
                                        title: Text(
                                            style: TextStyle(
                                                color: theme.textColor),
                                            currTheme.name),
                                        onTap: () {
                                          controller.changeThemeIndex(
                                              selectableThemes
                                                  .indexOf(currTheme));
                                          Navigator.pop(context);
                                        },
                                      );
                                    }).toList(),
                                  ),
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
                        },
                      );
                    },
                  ),
                ),
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
                    onPressed: () => {setSystemCalendar(context)},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

abstract class SettingsController extends StateNotifier<SettingsModel> {
  SettingsController(SettingsModel state) : super(state);

  void setUsedCalendar(Calendar? calendar);

  void changeThemeIndex(int index);
}
