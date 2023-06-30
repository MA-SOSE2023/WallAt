import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/custom_theme_data.dart';
import '/pages/folders/folder_item.dart';
import '/pages/folders/folder_model.dart';
import '/common/provider.dart';

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
    final List<FolderItem> contents = _folder.contents ?? [];
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    Widget gridItem(
      FolderItem item, {
      double padding = 4.0,
      VoidCallback? onTapped,
    }) =>
        GestureDetector(
          onTap: onTapped ?? FolderItem.navigateTo(item, context, ref),
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
        );

    List<Widget> threeMainItems() =>
        contents.take(3).map((item) => gridItem(item)).toList();

    Widget secondaryGrid() {
      final VoidCallback onTapped =
          FolderItem.navigateTo(_folder, context, ref);

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
            onTap: FolderItem.navigateTo(_folder, context, ref),
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: theme.groupingColor,
              ),
              child: itemGrid(
                [
                  ...threeMainItems(),
                  if (contents.length > 3) secondaryGrid(),
                ],
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
