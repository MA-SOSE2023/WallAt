import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/pages/settings/settings_view.dart';

import 'profile_model.dart';
import 'profiles_view.dart';
import '/common/provider.dart';

class ProfilesControllerImpl extends ProfilesController {
  ProfilesControllerImpl({List<ProfileModel>? model, required Ref ref})
      : _ref = ref,
        super(model ?? []) {
    _loadProfiles();
  }

  final Ref _ref;

  void _loadProfiles() async {
    SettingsController controller =
        _ref.read(Providers.settingsControllerProvider.notifier);
    List<ProfileModel> profiles = await controller.getAvailableProfies();
    state = profiles;
  }

  @override
  Image? getProfilePicture(ProfileModel profile) {
    return Image(image: profile.profilePicture);
  }

  @override
  void createProfile(String name, ImageProvider<Object> image) {
    ProfileModel newProfile = ProfileModel(
      id: state.length.toString(),
      name: name,
      profilePicture: image,
    );
    _ref.read(Providers.settingsControllerProvider.notifier).createProfile(
          newProfile,
        );
    state = [
      ...state,
      newProfile,
    ];
  }

  @override
  List<ImageProvider> getSelectableProfilePictures() => [
        const AssetImage('assets/dev_debug_images/mom.png'),
        const AssetImage('assets/dev_debug_images/dad.png'),
        const AssetImage('assets/dev_debug_images/daughter.png'),
        const AssetImage('assets/dev_debug_images/son.png'),
      ];

  @override
  void deleteProfile(int index) {
    _ref
        .read(Providers.settingsControllerProvider.notifier)
        .deleteProfile(index);
    state = [
      ...state.take(index),
      ...state.skip(index + 1),
    ];
  }
}
