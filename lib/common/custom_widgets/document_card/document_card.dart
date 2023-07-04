import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/single_item/single_item_view.dart';
import '/pages/single_item/model/single_item.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';

class DocumentCard extends ConsumerWidget {
  const DocumentCard({
    required SingleItem item,
    super.key,
  }) : _item = item;

  final SingleItem _item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
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
              Text(_item.title,
                  style: TextStyle(color: theme.accentColor, fontSize: 20)),
              Text(_item.description,
                  maxLines: 2,
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .tabLabelTextStyle
                      .copyWith(fontSize: 12)),
            ],
          ),
          leading: HeroMode(
            enabled: ref.watch(Providers.enableHeroAnimationProvider),
            child: Hero(
              tag: singleItemHeroTag('${_item.id}'),
              child: Container(
                width: 80,
                height: 80,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.groupingColor,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: _item.image,
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.all(5),
              ),
            ),
          ),
          leadingSize: 80,
          onTap: _item.navigateTo(context, ref),
        ),
      ],
    );
  }
}
