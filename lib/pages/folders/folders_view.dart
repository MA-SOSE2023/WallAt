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
        CameraButtonHeroDestination,
        ErrorMessage,
        NoElementsMessage;

class FoldersScreen extends ConsumerWidget {
  const FoldersScreen({int folderId = 1, super.key}) : _folderId = folderId;

  final int _folderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<Folder?> rootFolder =
        ref.watch(Providers.foldersControllerProvider(_folderId));

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          FutureBuilder(
            future: rootFolder,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<FolderItem>? contents = snapshot.data?.contents;
                return CustomScrollView(
                  slivers: [
                    CupertinoSliverNavigationBar(
                      largeTitle: Text(snapshot.data?.title ?? 'Folders'),
                    ),
                    if (contents == null)
                      const SliverToBoxAdapter(
                        child: ErrorMessage(
                          message:
                              'No matching folder was found. Try restarting the app.',
                        ),
                      ),
                    if (contents != null && contents.isEmpty)
                      const SliverToBoxAdapter(
                        child: NoElementsMessage(
                          message:
                              'This folder is empty. Try adding some items.',
                        ),
                      ),
                    if (contents != null && contents.isNotEmpty) ...[
                      FolderBubbleGrid(
                          folder: contents
                              .where((item) => item.isFolder)
                              .map((item) => item.folder)
                              .toList()),
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
                      DocumentCardContainerList(
                        items: contents
                            .where((item) => item.isLeaf)
                            .map((item) => item.item)
                            .toList(),
                      ),
                    ]
                  ],
                );
              } else if (snapshot.hasError) {
                return const ErrorMessage(
                  message: 'An error occurred while loading the folder.',
                );
              } else {
                return const Center(child: CupertinoActivityIndicator());
              }
            },
          ),
          const CameraButtonHeroDestination(),
        ],
      ),
    );
  }
}

abstract class FoldersController extends StateNotifier<Future<Folder?>> {
  FoldersController(Future<Folder?> state) : super(state);

  void delete();

  void rename(String newName);

  void move(Folder newParent);

  void addItem(FolderItem item);

  void removeItem(FolderItem item);

  void moveItem(FolderItem item, Folder newParent);
}
