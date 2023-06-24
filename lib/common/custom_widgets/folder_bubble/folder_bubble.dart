import 'package:flutter/cupertino.dart';

import '/pages/folders/folder_item.dart';
import '/pages/folders/folder_model.dart';

class FolderBubble extends StatelessWidget {
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
  Widget build(BuildContext context) {
    Widget gridItem(FolderItem item,
            {double padding = 4.0, VoidCallback? onTapped}) =>
        GestureDetector(
          onTap: onTapped ?? FolderItem.navigateTo(item, context),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemGrey6, context),
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: item.thumbnail,
              ),
            ),
          ),
        );

    List<Widget> threeMainItems(List<FolderItem> items) =>
        items.take(3).map((item) => gridItem(item)).toList();

    Widget secondaryGrid() {
      final VoidCallback onTapped = FolderItem.navigateTo(_folder, context);
      if (_folder.contents.length > 7) {
        return itemGrid([
          ..._folder.contents
              .sublist(3, 6)
              .map((item) => gridItem(item, padding: 0.0, onTapped: onTapped))
              .toList(),
          GestureDetector(
            onTap: onTapped,
            child: const Icon(CupertinoIcons.ellipsis,
                color: CupertinoColors.systemGrey),
          )
        ]);
      } else {
        return GestureDetector(
          onTap: onTapped,
          child: itemGrid(_folder.contents
              .sublist(3)
              .map((item) => gridItem(item, padding: 0.0, onTapped: onTapped))
              .toList()),
        );
      }
    }

    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemGrey6, context),
            ),
            child: itemGrid(
              [
                ...threeMainItems(_folder.contents),
                secondaryGrid(),
              ],
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
