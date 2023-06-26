import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'folder_model.dart';
import 'folders_view.dart';
import '/pages/single_item/model/single_item.dart';
import '/common/provider.dart';
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

  int get id => maybeItem?.id ?? maybeFolder!.id;
  String get title => maybeItem?.title ?? maybeFolder!.title;

  List<FolderItem>? get contents => maybeFolder!.contents;

  String get heroTag =>
      isLeaf ? 'folderItem-itemHeroTag-$id' : 'folderItem-folderHeroTag-$id';

  static VoidCallback navigateTo(
      FolderItem item, BuildContext context, WidgetRef ref) {
    if (item.isLeaf) {
      return () => Routers.globalRouterDelegate.beamToNamed(
            '/item/${item.id}',
          );
    } else {
      return () => {
            ref.read(Providers.enableHeroAnimationProvider.notifier).state =
                true,
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FoldersScreen(folderId: item.id),
              ),
            )
          };
    }
  }
}
