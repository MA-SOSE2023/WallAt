import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'profile_model.dart';
import 'profiles_view.dart';
import '/pages/settings/settings_model.dart';
import '/common/provider.dart';
import '/common/services/persistence/persistence_service.dart';

class ProfilesControllerImpl extends ProfilesController {
  ProfilesControllerImpl(
      {List<ProfileModel>? model,
      required PersistenceService persistence,
      required Ref ref})
      : _ref = ref,
        _persistence = persistence,
        super(model ?? []) {
    _loadProfiles();
  }

  final Ref _ref;
  final PersistenceService _persistence;

  void _loadProfiles() async {
    List<ProfileModel> profiles = await _persistence.getAllProfiles();
    state = profiles;
  }

  @override
  Image? getProfilePicture(ProfileModel profile) {
    return Image(
      image: PersistenceService
          .selectableProfilePictures[profile.selectedImageIndex],
    );
  }

  @override
  Future<void> createProfile(String name, int selectedImageIndex) async {
    ProfileModel newProfile = await _persistence.createProfile(
        name: name, selectedImageIndex: selectedImageIndex);
    state = [
      ...state,
      newProfile,
    ];
  }

  @override
  void updateProfile(ProfileModel profile,
      {String? newName, int? selectedImageIndex}) {
    _persistence.updateProfile(profile);
    state = [
      ...state.take(state.indexOf(profile)),
      profile.copyWith(
        name: newName ?? profile.name,
        selectedImageIndex: selectedImageIndex ?? profile.selectedImageIndex,
      ),
      ...state.skip(state.indexOf(profile) + 1),
    ];
  }

  @override
  Future<void> deleteProfile(ProfileModel profile) async {
    final List<ProfileModel> profiles = await _persistence.getAllProfiles();
    await _persistence.deleteProfile(profile);
    SettingsModel settings = _ref.read(Providers.settingsControllerProvider);
    if (settings.selectedProfileId == profile.id) {
      final int profileIndex = profiles.indexOf(profile);
      final ProfileModel nextProfile =
          profiles[(profileIndex + 1) % profiles.length];

      _ref
          .read(Providers.settingsControllerProvider.notifier)
          .setProfileId(nextProfile.id);
    }
    state = [...state.where((p) => p != profile)];
  }

  @override
  ProfileModel getSelectedProfile() => state
      .where((p) =>
          p.id ==
          _ref.read(Providers.settingsControllerProvider).selectedProfileId)
      .first;
}
