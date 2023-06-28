import 'package:isar/isar.dart';

import '/pages/folders/folder_model.dart';
import '/common/services/persistence/isar/schemas/isar_folder.dart';
import '/common/services/persistence/persistence_service.dart';

class IsarFolderDao extends FolderDao {
  IsarFolderDao({
    required Future<Isar> db,
  }) : _db = db;

  final Future<Isar> _db;
  int? _rootFolderId;

  @override
  Future<Folder> create({required String title, int? parentFolderId}) =>
      _db.then(
        (isar) async => _isarRead(
                parentFolderId ?? _rootFolderId ?? (await createOrFindRoot()))
            .then(
          (parentFolder) => isar.writeTxnSync(() async {
            Id createdFolder = isar.isarFolders.putSync(IsarFolder()
              ..title = title
              ..parentFolder.value = parentFolder);
            return Folder(
              id: createdFolder,
              title: title,
              contents: [],
            );
          }),
        ),
      );

  @override
  Future<Id> createOrFindRoot() => _db.then((isar) async {
        IsarFolder? root =
            isar.isarFolders.filter().isRootEqualTo(true).findFirstSync();
        root ??= isar.isarFolders.getSync(await _createRoot())!;

        _rootFolderId = root.id;
        return root.id;
      });

  Future<Id> _createRoot() =>
      _db.then((isar) => isar.writeTxnSync(() async => isar.isarFolders.putSync(
            IsarFolder()
              ..title = 'Folders'
              ..isRoot = true
              ..parentFolder.value = null,
          )));

  @override
  Future<bool> delete(Id id) => _db.then((isar) => isar.isarFolders.delete(id));

  @override
  Future<Folder?> read(Id id) =>
      _isarRead(id).then((isarFolder) => isarFolder?.toFolder());

  Future<IsarFolder?> _isarRead(Id id) =>
      _db.then((isar) => isar.isarFolders.get(id));

  @override
  Future<List<Folder>> readAll() =>
      _db.then((isar) => isar.isarFolders.where().findAll().then((folders) =>
          folders.map((isarFolder) => isarFolder.toFolder()).toList()));

  @override
  Future<void> update(Folder item) => _isarRead(item.id).then((isarFolder) {
        if (isarFolder != null) {
          return _db.then((isar) => isar.writeTxnSync(() async {
                isar.isarFolders.putSync(isarFolder..title = item.title);
              }));
        }
      });

  @override
  Future<void> move(Folder folder, Folder newParent) =>
      _db.then((isar) => isar.writeTxnSync(() async {
            isar.isarFolders.putSync((await _isarRead(folder.id))!
              ..parentFolder.value = await _isarRead(newParent.id));
          }));
}
