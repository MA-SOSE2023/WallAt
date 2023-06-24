import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'folder_model.dart';
import 'folders_view.dart';
import '/pages/single_item/model/single_item.dart';
import '/router/router.dart';

abstract class FolderItem {
  FolderItem({
    required bool isLeaf,
    this.maybeFolder,
    this.maybeItem,
  }) : _isLeaf = isLeaf;

  final bool _isLeaf;

  SingleItem? maybeItem;
  Folder? maybeFolder;
  SingleItem get item => maybeItem!;
  Folder get folder => maybeFolder!;

  Widget get thumbnail;

  bool get isLeaf => _isLeaf;
  bool get isFolder => !_isLeaf;

  String get id => maybeItem?.id ?? maybeFolder!.id;
  String get title => maybeItem?.title ?? maybeFolder!.title;

  List<FolderItem> get contents => maybeFolder!.contents;

  String get heroTag =>
      isLeaf ? 'folderItem-item-$id' : 'folderItem-folder-$id';

  static VoidCallback navigateTo(FolderItem item, BuildContext context) {
    if (item.isLeaf) {
      return () => Routers.globalRouterDelegate.beamToNamed(
            '/item/${item.id}',
          );
    } else {
      return () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FoldersScreen(folderId: item.id),
            ),
          );
    }
  }
}
