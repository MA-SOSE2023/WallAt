import 'package:isar/isar.dart';

import '/pages/profiles/profile_model.dart';
import '/common/services/persistence/persistence_service.dart';
import '/common/services/persistence/isar/schemas/isar_profile.dart';

class IsarProfileDao extends ProfileDao {
  IsarProfileDao({required Isar db}) : _isar = db;

  final Isar _isar;

  @override
  Future<ProfileModel> create({
    required String name,
    required int selectedImageIndex,
  }) async {
    final Id createdProfileId = await _isar.writeTxnSync(
      () => _isar.isarProfiles.putSync(
        IsarProfile()
          ..name = name
          ..selectedImageIndex = selectedImageIndex,
      ),
    );
    return ProfileModel(
      id: createdProfileId,
      name: name,
      selectedImageIndex: selectedImageIndex,
    );
  }

  @override
  Future<bool> delete(int id) =>
      _isar.writeTxn(() => _isar.isarProfiles.delete(id));

  @override
  Future<ProfileModel?> read(int id) =>
      _isar.isarProfiles.get(id).then((profile) => profile?.toProfileModel());

  @override
  Future<List<ProfileModel>> readAll() => _isar.isarProfiles
      .filter()
      .isDefaultEqualTo(false)
      .findAll()
      .then((profiles) =>
          profiles.map((profile) => profile.toProfileModel()).toList());

  @override
  Future<void> update(ProfileModel item) async {
    final IsarProfile? profile = await _isar.isarProfiles.get(item.id);
    if (profile != null) {
      _isar.writeTxnSync(() {
        profile
          ..name = item.name
          ..selectedImageIndex = item.selectedImageIndex;
      });
    }
  }

  @override
  Future<int> createOrFindDefault() async {
    IsarProfile? defaultProfile =
        _isar.isarProfiles.filter().isDefaultEqualTo(true).findFirstSync();
    defaultProfile ??= _isar.isarProfiles.getSync(await _createDefault())!;
    return defaultProfile.id;
  }

  Future<Id> _createDefault() =>
      _isar.writeTxnSync(() async => _isar.isarProfiles.putSync(
            IsarProfile()
              ..name = 'Default'
              ..selectedImageIndex = -1
              ..isDefault = true,
          ));
}
