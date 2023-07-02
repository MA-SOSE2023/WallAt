import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'folder_item.dart';
import 'folder_model.dart';
import 'folders_view.dart';
import '/common/provider.dart';
import '/common/utils/async_persisting_controller_mixin.dart';

class FoldersControllerImpl extends FoldersController
    with AutoDisposeAsyncPersistingControllerMixin {
  @override
  FutureOr<Folder?> build(int arg) async {
    final Folder? folder = await persistence.getFolder(arg);
    // Register listeners for all children so that provider is updated
    // automatically when a child is updated
    for (FolderItem item in folder?.contents ?? []) {
      listener<T>(T? previous, T next) {
        if (previous != next) {
          updateChild(item);
        }
      }

      if (item.isLeaf) {
        ref.listen(Providers.singleItemControllerProvider(item.id), listener);
      } else {
        ref.listen(Providers.foldersControllerProvider(item.id), listener);
      }
    }
    return folder;
  }

  void updateChild(FolderItem item) async {
    final Folder? folder = await future;
    state = AsyncValue.data(
      folder?.copyWith(
        contents: [
          for (final FolderItem child in folder.contents ?? [])
            if (child.id == item.id) item else child
        ],
      ),
    );
  }

  @override
  Future persistUpdate(Folder updated) => persistence.updateFolder(updated);

  FoldersControllerImpl _getOtherController(int parentId) =>
      ref.read(Providers.foldersControllerProvider(parentId).notifier)
          as FoldersControllerImpl;

  /// Creates a folder from the given title and adds it to this folders state
  @override
  void addSubFolder(String title) async {
    final Folder? parentFolder = await future;
    final Folder subFolder = await persistence.createFolder(
        title: title, parentFolderId: parentFolder?.id);
    receiveItem(subFolder);
  }

  /// Deletes this folder from database and removes it from its parent
  @override
  void delete() async {
    final Folder? folder = await future;
    if (folder == null) {
      return;
    }
    final Folder? parentFolder = await persistence.getParentFolder(folder);
    if (parentFolder == null) {
      return;
    }
    _getOtherController(parentFolder.id).removeItem(folder);
  }

  /// Moves this folder into another folder
  @override
  void move(Folder newParent) async {
    final Folder? folder = await future;
    if (folder == null || folder.id == newParent.id) {
      return;
    }
    await persistence.moveFolder(folder, newParent);
    _getOtherController(newParent.id).receiveItem(folder);
    // invalidate own state to trigger refresh in parent folder
    ref.invalidateSelf();
  }

  @override
  void moveItem(FolderItem item, Folder newParent) async {
    final Folder? folder = await future;
    if (folder?.id == newParent.id) {
      return;
    }
    await (item.isLeaf
        ? persistence.moveSingleItem(item.item, newParent)
        : persistence.moveFolder(item.folder, newParent));
    _getOtherController(newParent.id).receiveItem(item);
    state = AsyncValue.data(
      folder?.copyWith(
        contents:
            folder.contents?.where((element) => element.id != item.id).toList(),
      ),
    );
  }

  /// Adds item to this folders state but does not write it to database
  @override
  void receiveItem(FolderItem item) async {
    final Folder? folder = await future;
    if (item.isFolder) {
      final List<FolderItem> subFolders = (folder?.contents ?? [])
          .where((element) => element.isFolder)
          .toList();
      final List<FolderItem> subItems =
          (folder?.contents ?? []).where((element) => element.isLeaf).toList();
      state = AsyncValue.data(
        folder?.copyWith(
          contents: [
            ...subFolders,
            item,
            ...subItems,
          ],
        ),
      );
    } else {
      state = AsyncValue.data(
        folder?.copyWith(
          contents: [...folder.contents ?? [], item],
        ),
      );
    }
  }

  /// Deletes item from this folders state and database
  @override
  Future<bool> removeItem(FolderItem item) async {
    final Folder? folder = await future;
    final bool deleteResult = await (item.isLeaf
        ? persistence.deleteSingleItem(item.item)
        : persistence.deleteFolder(item.folder));
    if (deleteResult && folder != null) {
      state = AsyncValue.data(
        folder.copyWith(
          contents: folder.contents
              ?.where((element) => element.id != item.id)
              .toList(),
        ),
      );
      ref.invalidateSelf;
    }
    return deleteResult;
  }

  /// Renames this folder
  @override
  void rename(String newName) async {
    final Folder? folder = await future;
    if (folder == null) {
      return;
    }
    state = AsyncValue.data(folder.copyWith(title: newName));
  }
}
