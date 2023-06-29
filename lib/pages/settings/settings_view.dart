import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/theme/theme_controller.dart';
import 'package:gruppe4/pages/profiles/profile_model.dart';
import '../../router/router.dart';
import '/common/custom_widgets/all_custom_widgets.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/provider.dart';
import 'settings_model.dart';
import '/pages/profiles/profiles_view.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsModel settings = ref.watch(Providers.settingsControllerProvider);
    SettingsController controller =
        ref.read(Providers.settingsControllerProvider.notifier);
    List<ProfileModel> profiles =
        ref.watch(Providers.profilesControllerProvider);
    ProfilesController profilesController =
        ref.read(Providers.profilesControllerProvider.notifier);

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
        middle: Text("Settings"),
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
              header: Text("Common"),
              children: [
                CupertinoListTile(
                  title: Text("Set a preferred color theme"),
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
                            title: Text('Select a theme'),
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
                                    header: Text("Themes"),
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
                                          print(ref
                                              .watch(Providers
                                                  .themeControllerProvider)
                                              .name);
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
                                child: Text('Cancel'),
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
                  title: Text("Set a system calendar"),
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
                CupertinoListTile(
                  title: Text(
                      "Selected User Profile: ${profiles[settings.selectedProfileIndex].name}"),
                  trailing: Padding(
                    padding:
                        const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: theme.accentColor, width: 2),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: profilesController
                                  .getProfilePicture(
                                      profiles[settings.selectedProfileIndex])!
                                  .image,
                              fit: BoxFit.fill)),
                    ),
                  ),
                )
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

  void setProfileIndex(int index);
}
