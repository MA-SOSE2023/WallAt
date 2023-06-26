import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../router/router.dart';
import '/common/custom_widgets/all_custom_widgets.dart';
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
