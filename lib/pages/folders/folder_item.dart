import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'folder_model.dart';
import 'folders_view.dart';
import '/pages/single_item/single_item_view.dart';
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

  String get heroTag => isLeaf ? singleItemHeroTag('$id') : 'folder-heroTag$id';

  VoidCallback navigateTo(BuildContext context, WidgetRef ref) {
    if (isLeaf) {
      return () {
        ref.read(Providers.enableHeroAnimationProvider.notifier).state = true;
        Routers.globalRouterDelegate.beamToNamed(
          '/item',
          data: item,
        );
      };
    } else {
      return () {
        ref.read(Providers.enableHeroAnimationProvider.notifier).state = true;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FoldersScreen(folder: folder),
          ),
        );
      };
    }
  }
}
