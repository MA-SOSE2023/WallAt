import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_or_edit_profile_dialog.dart';
import 'profiles_view.dart';
import 'profile_model.dart';
import '/pages/settings/settings_model.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';

class ProfileContainer extends ConsumerWidget {
  const ProfileContainer({required ProfileModel profile, super.key})
      : _profile = profile;

  final ProfileModel _profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    final SettingsModel settings =
        ref.watch(Providers.settingsControllerProvider);
    final ProfilesController profilesController =
        ref.read(Providers.profilesControllerProvider.notifier);
    return CupertinoContextMenu.builder(
      // Context menu allowing to edit or delete a profile
      actions: [
        CupertinoContextMenuAction(
          trailingIcon: CupertinoIcons.pencil,
          onPressed: () {
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return AddOrEditProfileDialog(
                    isAddDialog: false,
                    editProfile: _profile,
                  );
                });
          },
          child: const Text('Edit'),
        ),
        CupertinoContextMenuAction(
          isDestructiveAction: true,
          onPressed: () {
            profilesController.deleteProfile(_profile);
            context.beamBack();
          },
          trailingIcon: CupertinoIcons.trash,
          child: const Text('Delete'),
        ),
      ],
      builder: (context, animation) => Container(
        height: 170,
        decoration: BoxDecoration(
            color: theme.groupingColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.accentColor, width: 2),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image:
                          profilesController.getProfilePicture(_profile)!.image,
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Text(
              _profile.name,
              style: TextStyle(color: theme.textColor),
              maxLines: 1,
            ),
            if (_profile.id == settings.selectedProfileId)
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme.backgroundColor,
                  ),
                  child: Text(
                    "Currently Selected",
                    style: TextStyle(color: theme.textColor),
                  ),
                ),
              )
            else
              CupertinoButton(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: const Text("Select this profile"),
                onPressed: () => {
                  ref
                      .read(Providers.settingsControllerProvider.notifier)
                      .setProfileId(_profile.id),
                  context.beamBack(),
                },
              )
          ],
        ),
      ),
    );
  }
}
