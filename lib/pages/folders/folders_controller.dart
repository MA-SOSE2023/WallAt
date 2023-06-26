import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/services/persistence/persistence_service.dart';

import 'folder_item.dart';
import 'folder_model.dart';
import 'folders_view.dart';

class FoldersControllerImpl extends FoldersController {
  FoldersControllerImpl(int id, PersistenceService service)
      : super(service.getFolder(id));

  @override
  void addItem(FolderItem item) {
    // TODO: implement addItem
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
    // TODO: implement moveItem
  }

  @override
  void removeItem(FolderItem item) {
    // TODO: implement removeItem
  }

  @override
  void rename(String newName) {
    // TODO: implement rename
  }
}
