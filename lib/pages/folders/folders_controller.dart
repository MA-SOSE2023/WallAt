import 'package:gruppe4/pages/single_item/model/single_item.dart';

import 'folder_item.dart';
import 'folder_model.dart';
import 'folders_view.dart';
import '/common/utils/future_controller_mixin.dart';
import '/common/services/persistence/persistence_service.dart';

class FoldersControllerImpl extends FoldersController
    with FutureControllerMixin {
  FoldersControllerImpl(int id, PersistenceService service)
      : _service = service,
        super(service.getFolder(id));

  final PersistenceService _service;

  @override
  void addItem(FolderItem item) {
    // TODO: implement addItem
  }

  @override
  Future<void> addSubFolder(String title) {
    Future<Folder> createdFolder = state.then((state) =>
        _service.createFolder(title: title, parentFolderId: state?.id));

    return createdFolder.then((folder) {
      return futureState((state) =>
          state?.copyWith(contents: [...state.contents ?? [], folder]));
    });
  }

  @override
  void delete() {
    // TODO: implement delete
  }

  @override
  void move(Folder newParent) {
    // TODO: implement move
  }

  @override
  void moveItem(FolderItem item, Folder newParent) {
    futureState((state) => state?.copyWith(
        contents:
            state.contents?.where((element) => element != item).toList()));
    item.isLeaf
        ? _service.moveSingleItem(item.item, newParent)
        : _service.moveFolder(item.folder, newParent);
  }

  @override
  Future<void> moveItemHere(FolderItem item) {
    futureState(
        (state) => state?.copyWith(contents: [...state.contents ?? [], item]));
    return state.then((state) {
      if (state != null) {
        return item.isLeaf
            ? _service.moveSingleItem(item.item, state)
            : _service.moveFolder(item.folder, state);
      }
    });
  }

  @override
  Future<bool> removeItem(FolderItem item) {
    futureState((state) => state?.copyWith(
        contents:
            state.contents?.where((element) => element != item).toList()));
    return item.isLeaf
        ? _service.deleteSingleItem(item.item)
        : _service.deleteFolder(item.folder);
  }

  @override
  void rename(String newName) {
    // TODO: implement rename
  }
}
