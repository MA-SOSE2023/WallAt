import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/theme/custom_theme_data.dart';

import 'folder_model.dart';
import 'folder_item.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        FolderBubbleGrid,
        DocumentCardContainerList,
        CameraButtonHeroDestination,
        FutureSliverFolderBuilder;

class FoldersScreen extends ConsumerWidget {
  const FoldersScreen({Folder? folder, int? folderId, super.key})
      : _folder = folder,
        _folderId = folderId;

  final Folder? _folder;
  final int? _folderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<Folder?> rootFolder = _folderId != null
        ? ref.watch(Providers.foldersControllerProvider(_folderId!))
        : _folder == null
            ? ref.watch(Providers.foldersControllerProvider(
                ref.read(Providers.dbControllerProvider).rootFolderId!))
            : Future.value(_folder);

    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    List<Widget> folderViewBody(List<FolderItem> contents, Folder rootFolder) =>
        [
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 10.0),
            sliver: SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              primary: false,
              toolbarHeight: 30.0,
              backgroundColor: theme.groupingColor,
              title: const Text('Subfolders', style: TextStyle(fontSize: 16)),
              centerTitle: true,
              actions: [
                CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    child: const Icon(CupertinoIcons.ellipsis),
                    onPressed: () {}),
                CupertinoButton(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    CupertinoIcons.plus,
                    color: theme.accentColor,
                  ),
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        String? newFolderName;
                        return CupertinoAlertDialog(
                          title: const Text('Add subfolder'),
                          content: CupertinoTextField(
                            placeholder: 'Folder title',
                            onChanged: (value) => newFolderName = value,
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            CupertinoDialogAction(
                              child: const Text('Add'),
                              onPressed: () {
                                ref
                                    .read(Providers.foldersControllerProvider(
                                            rootFolder.id)
                                        .notifier)
                                    .addSubFolder(newFolderName ?? 'Folder');
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
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
              backgroundColor: theme.groupingColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(bottom: 12),
                title: Divider(
                  height: 0.75,
                  thickness: 1,
                  indent: 24,
                  endIndent: 24,
                  color: theme.textColor.withOpacity(0.5),
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
        ];

    return CupertinoPageScaffold(
      backgroundColor: theme.backgroundColor,
      child: Stack(
        children: [
          if (_folder == null)
            FutureSliverFolderBuilder(
              future: rootFolder,
              success: folderViewBody,
            ),
          if (_folder != null)
            CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  backgroundColor: theme.navBarColor,
                  largeTitle: Text(_folder!.title),
                ),
                ...folderViewBody(_folder!.contents ?? [], _folder!)
              ],
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
  void addSubFolder(String title);

  Future<bool> removeItem(FolderItem item);

  void moveItem(FolderItem item, Folder newParent);

  Future<void> moveItemHere(FolderItem item);
}
