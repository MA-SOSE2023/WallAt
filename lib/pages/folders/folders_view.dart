import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'folder_model.dart';
import 'folder_item.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        FolderBubbleGrid,
        DocumentCardContainerList,
        CameraButtonHeroDestination;
import '/pages/single_item/model/single_item.dart';

class FoldersScreen extends ConsumerWidget {
  const FoldersScreen({int folderId = 0, super.key}) : _folderId = folderId;

  final int _folderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Folder rootFolder =
        ref.watch(Providers.foldersControllerProvider(_folderId));

    final List<Folder> folders = rootFolder.contents
        .where((element) => element.isFolder)
        .map((e) => e as Folder)
        .toList();

    final List<SingleItem> items = rootFolder.contents
        .where((element) => element.isLeaf)
        .map((e) => e as SingleItem)
        .toList();

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text(rootFolder.title),
              ),
              FolderBubbleGrid(folder: folders),
              SliverPadding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                sliver: SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: false,
                  toolbarHeight: 0.0,
                  backgroundColor: CupertinoDynamicColor.resolve(
                      CupertinoColors.systemGrey6, context),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(bottom: 12),
                    title: Divider(
                      height: 0.75,
                      thickness: 1,
                      indent: 24,
                      endIndent: 24,
                      color: CupertinoDynamicColor.resolve(
                          CupertinoColors.systemGrey, context),
                    ),
                  ),
                ),
              ),
              DocumentCardContainerList(items: items)
            ],
          ),
          const CameraButtonHeroDestination(),
        ],
      ),
    );
  }
}

abstract class FoldersController extends StateNotifier<Folder> {
  FoldersController(Folder state) : super(state);

  void delete();

  void rename(String newName);

  void move(Folder newParent);

  void addItem(FolderItem item);

  void removeItem(FolderItem item);

  void moveItem(FolderItem item, Folder newParent);

  List<FolderItem> get contents;
  String get title;
  int get id;
}
