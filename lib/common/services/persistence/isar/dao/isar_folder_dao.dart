import 'package:gruppe4/common/services/persistence/isar/schemas/isar_profile.dart';
import 'package:isar/isar.dart';

import '/pages/single_item/model/single_item.dart';
import '/pages/folders/folder_model.dart';
import '/common/services/persistence/isar/schemas/isar_single_item.dart';
import '/common/services/persistence/isar/schemas/isar_folder.dart';
import '/common/services/persistence/persistence_service.dart';

class IsarFolderDao extends FolderDao {
  IsarFolderDao({required Isar db}) : _isar = db;

  final Isar _isar;
  int? _rootFolderId;

  @override
  Future<Folder> create({
    required String title,
    int? parentFolderId,
    required int profileId,
  }) async {
    final IsarFolder? parentFolder = await _isarRead(
        parentFolderId ?? _rootFolderId ?? (await createOrFindRoot(profileId)));
    final IsarProfile? profile = await _isar.isarProfiles.get(profileId);
    return _isar.writeTxnSync(() {
      Id createdFolder = _isar.isarFolders.putSync(
        IsarFolder()
          ..title = title
          ..parentFolder.value = parentFolder
          ..profile.value = profile,
      );
      return Folder(
        id: createdFolder,
        title: title,
        contents: [],
      );
    });
  }

  @override
  Future<Id> createOrFindRoot(int profileId) async {
    IsarFolder? root = _isar.isarFolders
        .filter()
        .isRootEqualTo(true)
        .profile((q) => q.idEqualTo(profileId))
        .findFirstSync();
    root ??= _isar.isarFolders.getSync(await _createRoot(profileId))!;
    _rootFolderId = root.id;
    return root.id;
  }

  Future<Id> _createRoot(int profileId) {
    final IsarProfile? profile = _isar.isarProfiles.getSync(profileId);
    return _isar.writeTxnSync(() async => _isar.isarFolders.putSync(
          IsarFolder()
            ..title = 'Folders'
            ..isRoot = true
            ..parentFolder.value = null
            ..profile.value = profile,
        ));
  }

  @override
  Future<bool> delete(Id id) =>
      _isar.writeTxn(() => _isar.isarFolders.delete(id));

  @override
  Future<Folder?> read(Id id) =>
      _isarRead(id).then((isarFolder) => isarFolder?.toFolder());

  Future<IsarFolder?> _isarRead(Id id) => _isar.isarFolders.get(id);

  @override
  Future<List<Folder>> readAll(int? profileId) {
    if (profileId != null) {
      return _isar.isarFolders
          .filter()
          .profile((q) => q.idEqualTo(profileId))
          .findAll()
          .then((folders) =>
              folders.map((isarFolder) => isarFolder.toFolder()).toList());
    }
    return _isar.isarFolders.where().findAll().then((folders) =>
        folders.map((isarFolder) => isarFolder.toFolder()).toList());
  }

  @override
  Future<int?> findItemParentId(Id childId) async {
    final IsarSingleItem? isarItem = await _isar.isarSingleItems.get(childId);
    return isarItem?.parentFolder.value?.id;
  }

  @override
  Future<int?> findFolderParentId(Id childId) async {
    final IsarFolder? isarFolder = await _isar.isarFolders.get(childId);
    return isarFolder?.parentFolder.value?.id;
  }

  @override
  Future<void> update(Folder item) async {
    final IsarFolder? isarFolder = await _isarRead(item.id);
    if (isarFolder != null) {
      return _isar.writeTxnSync(() async {
        _isar.isarFolders.putSync(isarFolder..title = item.title);
      });
    }
  }

  @override
  Future<void> move(Folder folder, Folder newParent) =>
      _isar.writeTxnSync(() async {
        _isar.isarFolders.putSync((await _isarRead(folder.id))!
          ..parentFolder.value = await _isarRead(newParent.id));
      });

  @override
  Future<bool> deleteItemFromFolder(SingleItem item) async {
    final IsarSingleItem? isarItem = await _isar.isarSingleItems.get(item.id);
    if (isarItem != null) {
      return _isar
          .writeTxnSync(() => _isar.isarSingleItems.deleteSync(item.id));
    }
    return false;
  }

  @override
  Future<void> moveToProfile(Folder folder, int newProfile) async {
    final IsarFolder? isarFolder = await _isar.isarFolders.get(folder.id);
    final IsarProfile? profile = await _isar.isarProfiles.get(newProfile);
    if (isarFolder != null && profile != null) {
      _isar.writeTxnSync(() {
        _isar.isarFolders.putSync(isarFolder..profile.value = profile);
      });
    }
  }
}
