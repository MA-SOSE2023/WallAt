import 'package:flutter/cupertino.dart';

import 'profile_model.dart';
import 'profiles_view.dart';

List<ProfileModel> profiles = [
  const ProfileModel(
      id: "1",
      name: "Mom",
      profilePicture: AssetImage('assets/dev_debug_images/mom.png')),
  const ProfileModel(
      id: "2",
      name: "Dad",
      profilePicture: AssetImage('assets/dev_debug_images/dad.png')),
  const ProfileModel(
      id: "3",
      name: "Tochter",
      profilePicture: AssetImage('assets/dev_debug_images/daughter.png')),
  const ProfileModel(
      id: "4",
      name: "Sohn",
      profilePicture: AssetImage('assets/dev_debug_images/son.png')),
];

class ProfilesControllerImpl extends ProfilesController {
  ProfilesControllerImpl({List<ProfileModel>? model})
      : super(model ?? profiles);

  @override
  void setCurrentProfile(ProfileModel profile) {
    //todo implement
  }

  @override
  Image? getProfilePicture(ProfileModel profile) {
    return Image(image: profile.profilePicture);
  }
}