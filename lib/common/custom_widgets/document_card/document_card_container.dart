import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'document_card.dart';
import '/common/provider.dart';
import '/pages/single_item/model/single_item.dart';

class DocumentCardContainer extends ConsumerWidget {
  const DocumentCardContainer({required String id, super.key}) : _id = id;

  final String _id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SingleItem doc = ref.watch(
      Providers.singleItemControllerProvider(_id),
    );
    return Container(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: CupertinoDynamicColor.resolve(CupertinoColors.label, context),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(child: DocumentCard(id: _id)),
          CupertinoButton(
            onPressed: ref
                .read(Providers.singleItemControllerProvider(_id).notifier)
                .setFavorite,
            child: Icon(doc.isFavorite
                ? CupertinoIcons.heart_fill
                : CupertinoIcons.heart),
          ),
        ],
      ),
    );
  }
}
