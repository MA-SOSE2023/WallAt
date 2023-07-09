import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/theme/custom_theme_data.dart';

import 'folder_model.dart';
import 'folder_item.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        LoadingSliverFolderBuilder,
        CameraButtonHeroDestination,
        DocumentCardContainerList,
        FolderBubbleGrid;

class FoldersScreen extends ConsumerWidget {
  const FoldersScreen({Folder? folder, super.key}) : _folder = folder;

  final Folder? _folder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    List<Widget> folderViewBody(List<FolderItem> contents, Folder folder) => [
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 10.0),
            sliver: SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              primary: false,
              toolbarHeight: 30.0,
              backgroundColor: theme.groupingColor,
              title: Text('Subfolders',
                  style: TextStyle(fontSize: 16, color: theme.textColor)),
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
                                            _folder?.id)
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

    final Folder folder = ref.watch(
      Providers.foldersControllerProvider(_folder?.id),
    );

    return CupertinoPageScaffold(
      backgroundColor: theme.backgroundColor,
      child: Stack(
        children: [
          LoadingSliverFolderBuilder(
            folder: folder,
            initialData: _folder,
            success: folderViewBody,
          ),
          const CameraButtonHeroDestination(),
        ],
      ),
    );
  }
}

abstract class FoldersController extends StateNotifier<Folder> {
  FoldersController(super.state);

  void delete();

  void rename(String newName);

  void move(Folder newParent);

  void receiveItem(FolderItem item);
  void addSubFolder(String title);

  Future<bool> removeItem(FolderItem item);

  void moveItem(FolderItem item, Folder newParent);
}
