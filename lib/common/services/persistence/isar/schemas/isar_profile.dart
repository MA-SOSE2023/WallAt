import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';

import '/pages/profiles/profile_model.dart';

part 'isar_profile.g.dart';

@collection
class IsarProfile {
  Id id = Isar.autoIncrement;

  bool isDefault = false;

  @Index(type: IndexType.value)
  late String name;

  late int selectedImageIndex;

  ProfileModel toProfileModel() => ProfileModel(
        id: id,
        name: name,
        selectedImageIndex: selectedImageIndex,
      );
}
