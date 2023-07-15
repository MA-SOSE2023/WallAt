import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'single_item_view.dart';

class FullScreenImagePage extends StatelessWidget {
  const FullScreenImagePage({
    Key? key,
    required this.itemId,
    required this.imageProvider,
  }) : super(key: key);

  final int itemId;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      backgroundColor: Colors.transparent,
      child: SafeArea(
        child: PhotoView(
          heroAttributes:
              PhotoViewHeroAttributes(tag: singleItemHeroTag('$itemId')),
          imageProvider: imageProvider,
          backgroundDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
