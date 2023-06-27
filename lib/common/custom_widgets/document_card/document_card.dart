import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/pages/single_item/single_item_view.dart';
import '/pages/single_item/model/single_item.dart';

class DocumentCard extends ConsumerWidget {
  const DocumentCard({
    required SingleItem item,
    super.key,
  }) : _item = item;

  final SingleItem _item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SingleItem item =
        ref.watch(Providers.singleItemControllerProvider(_item.id));
    final bool heroEnabled = ref.watch(Providers.enableHeroAnimationProvider);
    final SingleItemController controller =
        ref.watch(Providers.singleItemControllerProvider(_item.id).notifier);
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
              Text(item.title,
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navActionTextStyle
                      .copyWith(fontSize: 20)),
              Text(item.description,
                  maxLines: 2,
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .tabLabelTextStyle
                      .copyWith(fontSize: 12)),
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
              child: HeroMode(
                enabled: heroEnabled,
                child: Hero(
                  tag: singleItemHeroTag('$item.id'),
                  child: Image(
                    image: controller.getImage().image,
                  ),
                ),
              ),
            ),
          ),
          leadingSize: 80,
          onTap: () {
            ref.read(Providers.enableHeroAnimationProvider.notifier).state =
                true;
            controller.navigateToThisItem();
          },
        ),
      ],
    );
  }
}
