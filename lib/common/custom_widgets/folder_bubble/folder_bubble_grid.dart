import 'package:flutter/cupertino.dart';

import 'folder_bubble.dart';
import '/pages/folders/folder_model.dart';

class FolderBubbleGrid extends StatelessWidget {
  const FolderBubbleGrid({required List<Folder> folder, super.key})
      : _folder = folder;

  final List<Folder> _folder;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double bubbleWidth = width / 2 + 10;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: bubbleWidth,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 20.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => FolderBubble(folder: _folder[index]),
        childCount: _folder.length,
      ),
    );
  }
}
