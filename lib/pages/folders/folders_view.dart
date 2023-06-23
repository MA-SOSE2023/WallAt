import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/pages/single_item/model/single_item.dart';

import 'folder_model.dart';
import 'folder_item.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show DocumentCardContainer, CameraButtonHeroDestination;

class FoldersScreen extends ConsumerWidget {
  const FoldersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Folder rootFolder =
        ref.watch(Providers.foldersControllerProvider('0'));

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
              const CupertinoSliverNavigationBar(
                largeTitle: Text('Folders'),
              ),
              // SliverGrid to display root level folders
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    color: CupertinoTheme.of(context).primaryColor,
                    child: Text(
                        '${folders[index].title}: ${folders[index].contents.length} items'),
                  ),
                  childCount: folders.length,
                ),
              ),
              SliverPrototypeExtentList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: [
                        Divider(
                            height: 16.0,
                            thickness: 0.75,
                            indent: 64.0,
                            color: CupertinoDynamicColor.resolve(
                                CupertinoColors.inactiveGray, context)),
                        DocumentCardContainer.borderless(item: items[index]),
                      ],
                    ),
                  ),
                  childCount: items.length,
                ),
                prototypeItem: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: [
                      DocumentCardContainer.borderless(
                        item: SingleItem(
                          description: 'prototype',
                          id: 'prototype',
                          title: 'prototype',
                          events: [],
                          image: '',
                          isFavorite: false,
                        ),
                      ),
                      const Divider(
                        height: 16.0,
                        thickness: 0.75,
                      )
                    ],
                  ),
                ),
              ),
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
  String get id;
}
