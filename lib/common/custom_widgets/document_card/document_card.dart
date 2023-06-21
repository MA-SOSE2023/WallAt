import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/single_item/single_item_view.dart';
import '/common/provider.dart';

class DocumentCard extends ConsumerWidget {
  const DocumentCard({
    required String id,
    super.key,
  }) : _id = id;

  final String _id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SingleItemController controller = ref.watch(
      Providers.singleItemControllerProvider(_id).notifier,
    );
    return CupertinoListSection.insetGrouped(
      margin: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      children: [
        CupertinoListTile.notched(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.getTitle(),
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navActionTextStyle
                      .copyWith(fontSize: 20)),
              Text(
                controller.getDescription(),
                maxLines: 2,
                style: CupertinoTheme.of(context).textTheme.tabLabelTextStyle,
              ),
            ],
          ),
          leading: Container(
            width: 80,
            height: 80,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(5),
            child: FittedBox(
              fit: BoxFit.cover,
              child: Hero(
                tag: singleItemHeroTag(_id),
                child: Image(
                  image: controller.getImage().image,
                ),
              ),
            ),
          ),
          leadingSize: 80,
          onTap: () {
            controller.navigateToThisItem();
          },
        ),
      ],
    );
  }
}
