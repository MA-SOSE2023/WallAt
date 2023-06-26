import 'package:isar/isar.dart';

import '/pages/folders/folder_model.dart';
import '/common/services/persistence/isar/schemas/isar_folder.dart';
import '/common/services/persistence/persistence_service.dart';

class IsarFolderDio extends FolderDio {
  IsarFolderDio({required Future<Isar> db}) : _db = db;

  final Future<Isar> _db;
  int? _rootFolderId;

  @override
  Future<Folder> create({required String title, int? parentFolderId}) async {
    final isar = await _db;
    return isar.writeTxnSync(() async {
      Id createdFolder = isar.isarFolders.putSync(IsarFolder()
        ..title = title
        ..parentFolder.value = await _isarRead(
            parentFolderId ?? _rootFolderId ?? (await createOrFindRoot())));
      return Folder(
        id: createdFolder,
        title: title,
        contents: [],
      );
    });
  }

  @override
  Future<Id> createOrFindRoot() async {
    final isar = await _db;
    IsarFolder? root =
        await isar.isarFolders.filter().isRootEqualTo(true).findFirst();
    root ??= (await isar.isarFolders.get(await _createRoot()))!;

    _rootFolderId = root.id;
    return root.id;
  }

  Future<Id> _createRoot() async {
    final isar = await _db;
    return isar.writeTxnSync(() async => isar.isarFolders.putSync(
          IsarFolder()
            ..title = 'Folders'
            ..isRoot = true
            ..parentFolder.value = null,
        ));
  }

  @override
  Future<bool> delete(Id id) async {
    final isar = await _db;
    return isar.isarFolders.delete(id);
  }

  @override
  Future<Folder?> read(Id id) async {
    final isarFolder = _isarRead(id);
    return isarFolder.then((isarFolder) => isarFolder?.toFolder());
  }

  Future<IsarFolder?> _isarRead(Id id) async {
    final isar = await _db;
    return isar.isarFolders.get(id);
  }

  @override
  Future<List<Folder>> readAll() async {
    final isar = await _db;
    return isar.isarFolders.where().findAll().then((folders) =>
        folders.map((isarFolder) => isarFolder.toFolder()).toList());
  }

  @override
  Future<void> update(Folder item) async {
    final isar = await _db;
    IsarFolder? isarFolder = (await _isarRead(item.id));
    if (isarFolder != null) {
      isar.isarFolders.put(isarFolder..title = item.title);
    }
  }

  @override
  Future<void> move(Folder folder, Folder newParent) async {
    final isar = await _db;
    isar.isarFolders.put((await _isarRead(folder.id))!
      ..parentFolder.value = await _isarRead(newParent.id));
  }
}
