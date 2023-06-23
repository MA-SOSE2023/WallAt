import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'document_card.dart';
import '/common/provider.dart';
import '/pages/single_item/model/single_item.dart';

class DocumentCardContainer extends ConsumerWidget {
  const DocumentCardContainer({
    required SingleItem item,
    BoxDecoration? containerDeco,
    Color? backgroundColor,
    super.key,
  })  : _item = item,
        _containerDeco = containerDeco,
        _backgroundColor = backgroundColor;

  DocumentCardContainer.borderless({
    required SingleItem item,
    Color? backgroundColor,
    super.key,
  })  : _item = item,
        _containerDeco = BoxDecoration(
          color: backgroundColor,
        ),
        _backgroundColor = backgroundColor;

  final SingleItem _item;
  final BoxDecoration? _containerDeco;
  final Color? _backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: _containerDeco ??
          BoxDecoration(
            color: _backgroundColor ??
                CupertinoTheme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color:
                  CupertinoDynamicColor.resolve(CupertinoColors.label, context),
              width: 1,
            ),
          ),
      child: Row(
        children: [
          Expanded(child: DocumentCard(item: _item)),
          CupertinoButton(
            onPressed: ref
                .read(Providers.singleItemControllerProvider(_item.id).notifier)
                .setFavorite,
            child: Icon(_item.isFavorite
                ? CupertinoIcons.heart_fill
                : CupertinoIcons.heart),
          ),
        ],
      ),
    );
  }
}
