import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/folders/folder_item.dart';
import '/pages/folders/folder_model.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show LoadingOptionBuilder;

class FolderBubble extends ConsumerWidget {
  const FolderBubble({required Folder folder, super.key}) : _folder = folder;

  final Folder _folder;

  Widget itemGrid(List<Widget> children) => GridView.count(
        padding: const EdgeInsets.all(6),
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
        children: children,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Folder folder =
        ref.watch(Providers.foldersControllerProvider(_folder.id));
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    final VoidCallback onTapped = _folder.navigateTo(context, ref);

    Widget gridItem(
      FolderItem item, {
      double padding = 4.0,
      VoidCallback? onTapped,
    }) =>
        GestureDetector(
          onTap: onTapped ?? item.navigateTo(context, ref),
          child: HeroMode(
            enabled: ref.watch(Providers.enableHeroAnimationProvider),
            child: Hero(
              tag: item.heroTag,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: theme.groupingColor,
                  image: item.isLeaf
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: item.item.image,
                        )
                      : null,
                ),
                child: item.isFolder
                    ? Padding(
                        padding: EdgeInsets.all(padding),
                        child: const FittedBox(
                          fit: BoxFit.cover,
                          clipBehavior: Clip.hardEdge,
                          child: Icon(CupertinoIcons.folder),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        );

    List<Widget> threeMainItems(List<FolderItem> contents) {
      final List<FolderItem> subFolders =
          contents.where((item) => item.isFolder).take(3).toList();
      // sort items, so that folders are always shown first
      if (subFolders.length < 3) {
        return [
          ...subFolders.map((item) => gridItem(item)).toList(),
          ...contents
              .where((item) => item.isLeaf)
              .take(3 - subFolders.length)
              .map((item) => gridItem(item))
              .toList(),
        ];
      }
      return subFolders.map((item) => gridItem(item)).toList();
    }

    Widget secondaryGrid(List<FolderItem> contents) {
      if (contents.length > 7) {
        return GestureDetector(
            onTap: onTapped,
            child: itemGrid([
              ...contents
                  .sublist(3, 6)
                  .map((item) =>
                      gridItem(item, padding: 0.0, onTapped: onTapped))
                  .toList(),
              const Icon(CupertinoIcons.ellipsis,
                  color: CupertinoColors.systemGrey),
            ]));
      } else {
        return GestureDetector(
          onTap: onTapped,
          child: itemGrid(
            contents
                .sublist(3)
                .map((item) => gridItem(item, padding: 0.0, onTapped: onTapped))
                .toList(),
          ),
        );
      }
    }

    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _folder.navigateTo(context, ref),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: theme.groupingColor,
              ),
              child: LoadingOptionBuilder(
                resource: folder,
                initialData: _folder,
                success: (folder) => itemGrid(
                  [
                    ...threeMainItems(folder.contents ?? []),
                    if ((folder.contents?.length ?? 0) > 3)
                      secondaryGrid(folder.contents ?? []),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(_folder.title,
              textAlign: TextAlign.center,
              style: CupertinoTheme.of(context).textTheme.textStyle),
        ),
      ],
    );
  }
}
