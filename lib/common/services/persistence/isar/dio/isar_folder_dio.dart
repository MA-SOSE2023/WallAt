import 'package:isar/isar.dart';

import '/pages/folders/folder_model.dart';
import '/common/services/persistence/isar/schemas/isar_folder.dart';
import '/common/services/persistence/persistence_service.dart';

class IsarFolderDio extends FolderDio {
  IsarFolderDio({required Future<Isar> db}) : _db = db;

  final Future<Isar> _db;

  @override
  Future<Folder> create(
      {required String title, required int parentFolderId}) async {
    final isar = await _db;
    return isar.writeTxnSync(() async {
      Id createdFolder = isar.isarFolders.putSync(IsarFolder()
        ..title = title
        ..parentFolder.value = await _read(parentFolderId));
      return Folder(
        id: createdFolder.toString(),
        title: title,
        contents: [],
      );
    });
  }

  @override
  Future<void> delete(Id id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Folder> read(Id id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  Future<IsarFolder?> _read(Id id) async {
    final isar = await _db;
    return isar.isarFolders.get(id);
  }

  @override
  Future<List<Folder>> readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<void> update(Folder item) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  // TODO: implement rootFolderId
  Future<int> get rootFolderId => throw UnimplementedError();
}
