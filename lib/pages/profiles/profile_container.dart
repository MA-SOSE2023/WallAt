import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return Container(
      decoration: BoxDecoration(
          color: theme.groupingColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.accentColor, width: 2),
                  shape: BoxShape.circle,
                  image: _profile.selectedImageIndex < 0
                      ? null
                      : DecorationImage(
                          image: profilesController
                              .getProfilePicture(_profile)!
                              .image,
                          fit: BoxFit.fill),
                ),
                child: _profile.selectedImageIndex < 0
                    ? const Icon(
                        CupertinoIcons.person,
                        size: 70,
                      )
                    : null),
          ),
          Text(_profile.name, style: TextStyle(color: theme.textColor)),
          if (_profile.id == settings.selectedProfileId)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
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
              padding: EdgeInsets.zero,
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
    );
  }
}
