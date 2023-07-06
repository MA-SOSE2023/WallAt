import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'folder_item.dart';
import 'folder_model.dart';
import 'folders_view.dart';
import '/common/provider.dart';
import '/common/utils/persisting_controller_mixin.dart';
import '/common/services/persistence/persistence_service.dart';

class FoldersControllerImpl extends FoldersController
    with PersistingControllerMixin {
  FoldersControllerImpl(
      {required int folderId,
      required PersistenceService persistence,
      required this.ref})
      : _service = persistence,
        super(Folder.loading(id: folderId)) {
    persistence
        .getFolder(folderId)
        .then((value) => state = value!)
        .onError((error, stackTrace) {
      // TODO: add logging
      print('Error while fetching folder: $error');
      print(stackTrace);
      return state = state.copyWith(hasError: true);
    }).whenComplete(() => state = state.copyWith(isLoading: false));
  }

  final Ref ref;
  final PersistenceService _service;
  @override
  PersistenceService get persistence => _service;

  @override
  Future<void> persistUpdate(Folder updated) =>
      persistence.updateFolder(updated);

  void updateChild(FolderItem item) {
    state = state.copyWith(
      contents: [
        for (final FolderItem child in state.contents ?? [])
          if (child.id == item.id && child.isLeaf == item.isLeaf)
            item
          else
            child
      ],
    );
  }

  FoldersControllerImpl _getOtherController(int parentId) =>
      ref.read(Providers.foldersControllerProvider(parentId).notifier)
          as FoldersControllerImpl;

  /// Creates a folder from the given title and adds it to this folders state
  @override
  void addSubFolder(String title) async {
    final Folder subFolder =
        await persistence.createFolder(title: title, parentFolderId: state.id);
    receiveItem(subFolder);
  }

  /// Deletes this folder from database and removes it from its parent
  @override
  void delete() async {
    final Folder? parentFolder = await persistence.getParentFolder(state);
    if (parentFolder == null) {
      return;
    }
    _getOtherController(parentFolder.id).removeItem(state);
  }

  /// Moves this folder into another folder
  @override
  void move(Folder newParent) async {
    if (state.id == newParent.id) {
      return;
    }
    await persistence.moveFolder(state, newParent);
    _getOtherController(newParent.id).receiveItem(state);
    // invalidate own state to trigger refresh in parent folder
    ref.invalidateSelf();
  }

  @override
  void moveItem(FolderItem item, Folder newParent) async {
    if (state.id == newParent.id) {
      return;
    }
    await (item.isLeaf
        ? persistence.moveSingleItem(item.item, newParent)
        : persistence.moveFolder(item.folder, newParent));
    _getOtherController(newParent.id).receiveItem(item);
    state = state.copyWith(
      contents:
          state.contents?.where((element) => element.id != item.id).toList(),
    );
  }

  /// Adds item to this folders state but does not write it to database
  @override
  void receiveItem(FolderItem item) async {
    final Iterable<FolderItem> subFolders =
        state.contents?.where((item) => item.isFolder) ?? [];
    final Iterable<FolderItem> subItems =
        state.contents?.where((item) => item.isLeaf) ?? [];
    state = state.copyWith(
      contents: [...subFolders, item, ...subItems],
    );
  }

  /// Deletes item from this folders state and database
  @override
  Future<bool> removeItem(FolderItem item) async {
    final bool deleteResult = await (item.isLeaf
        ? persistence.deleteSingleItem(item.item)
        : persistence.deleteFolder(item.folder));
    if (deleteResult) {
      state = state.copyWith(
        contents:
            state.contents?.where((element) => element.id != item.id).toList(),
      );
      ref.invalidateSelf;
    }
    return deleteResult;
  }

  /// Renames this folder
  @override
  void rename(String newName) async => state = state.copyWith(title: newName);
}
