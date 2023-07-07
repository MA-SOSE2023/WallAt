import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_model.dart';
import '/common/custom_widgets/all_custom_widgets.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/provider.dart';
import '/pages/profiles/profile_model.dart';
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

    return CupertinoPageScaffold(
      backgroundColor: theme.groupingColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: theme.navBarColor,
        middle: const Text("Settings"),
      ),
      child: SafeArea(
        child: CustomScrollView(
          scrollBehavior: const CupertinoScrollBehavior(),
          slivers: [
            SliverToBoxAdapter(
              child: CustomFormSection(children: [
                CupertinoListTile.notched(
                  title: const Text("Custom Theme"),
                  subtitle: Text(
                    "Current Theme: ${ref.watch(Providers.themeControllerProvider).name}",
                  ),
                  trailing: const Icon(CupertinoIcons.forward),
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SelectionDialog(
                          title: 'Select a theme',
                          selectables: selectableThemes,
                          onTapped: (theme) => controller.changeThemeIndex(
                            selectableThemes.indexOf(theme),
                          ),
                          isSelected: (theme) =>
                              theme ==
                              selectableThemes[settings.selectedThemeIndex],
                          builder: (theme) => Text(theme.name),
                        );
                      },
                    );
                  },
                ),
              ]),
            ),
            SliverToBoxAdapter(
              child: CustomFormSection(children: [
                CupertinoListTile.notched(
                  title: const Text("System Calendar"),
                  subtitle: Text(
                    (settings.calendar == null)
                        ? "No calendar selected"
                        : "Selected calendar: ${settings.calendar!.name}",
                    maxLines: 2,
                  ),
                  trailing: Icon(settings.calendar == null
                      ? CupertinoIcons.add
                      : CupertinoIcons.forward),
                  onTap: () => {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SelectCalendarPopup(
                          onCalendarSelected: (calendar) {
                            controller.setUsedCalendar(calendar);
                          },
                        );
                      },
                    )
                  },
                ),
                CupertinoListTile.notched(
                  title: const Text("User Profile"),
                  subtitle: Text(
                    "Current Profile: ${profiles[settings.selectedProfileIndex].name}",
                  ),
                  trailing: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: theme.accentColor, width: 2),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: profilesController
                                .getProfilePicture(
                                  profiles[settings.selectedProfileIndex],
                                )!
                                .image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const Icon(CupertinoIcons.forward),
                    ],
                  ),
                  onTap: () => {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SelectionDialog(
                          title: 'Select a profile',
                          selectables: profiles,
                          onTapped: (profile) => controller.setProfileIndex(
                            profiles.indexOf(profile),
                          ),
                          isSelected: (profile) =>
                              profile ==
                              profiles[settings.selectedProfileIndex],
                          builder: (profile) => Row(children: [
                            Container(
                              height: 30,
                              width: 30,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: theme.accentColor, width: 2),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: profilesController
                                      .getProfilePicture(profile)!
                                      .image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Text(profile.name)
                          ]),
                        );
                      },
                    )
                  },
                ),
              ]),
            ),
          ],
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

  Future<List<ProfileModel>> getAvailableProfies();

  void createProfile(ProfileModel profile);

  void deleteProfile(int index);
}
