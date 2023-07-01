import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'folder_item.dart';
import 'folder_model.dart';
import 'folders_view.dart';
import '/common/utils/persisting_controller_mixin.dart';

class FoldersControllerImpl extends FoldersController
    with PersistingControllerMixin {
  @override
  FutureOr<Folder?> build(int? arg) async =>
      persistence.getFolder(arg ?? await persistence.rootFolderId);

  @override
  Future persistUpdate(Folder updated) => persistence.updateFolder(updated);

  @override
  void addItem(FolderItem item) {
    // TODO: implement addItem
  }

  @override
  void addSubFolder(String title, int parentFolderId) async {
    final Folder subFolder = await persistence.createFolder(
        title: title, parentFolderId: parentFolderId);
    state = state.whenData((folder) =>
        folder?.copyWith(contents: [...folder.contents ?? [], subFolder]));
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
  void moveItem(FolderItem item, Folder newParent) async {
    await (item.isLeaf
        ? persistence.moveSingleItem(item.item, newParent)
        : persistence.moveFolder(item.folder, newParent));
    state = state.whenData((folder) => folder?.copyWith(
        contents:
            folder.contents?.where((element) => element != item).toList()));
  }

  @override
  Future<bool> removeItem(FolderItem item) {
    state = state.whenData((folder) => folder?.copyWith(
        contents:
            folder.contents?.where((element) => element != item).toList()));
    return item.isLeaf
        ? persistence.deleteSingleItem(item.item)
        : persistence.deleteFolder(item.folder);
  }

  @override
  void rename(String newName) {
    // TODO: implement rename
  }
}
