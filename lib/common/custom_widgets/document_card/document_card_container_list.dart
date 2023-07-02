import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'document_card_container.dart';

import '/pages/single_item/model/single_item.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show DocumentCardContainer;

class DocumentCardContainerList extends ConsumerWidget {
  const DocumentCardContainerList({
    required List<SingleItem> items,
    bool borderlessCards = true,
    bool showFavoriteButton = true,
    double itemMargin = 20.0,
    super.key,
  })  : _items = items,
        _borderlessCards = borderlessCards,
        _itemMargin = itemMargin,
        _showFavoriteButton = showFavoriteButton;

  final List<SingleItem> _items;
  final bool _borderlessCards;
  final double _itemMargin;
  final bool _showFavoriteButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    Widget padding(Widget child) => Padding(
        padding: _borderlessCards
            ? const EdgeInsets.all(0.0)
            : EdgeInsets.fromLTRB(20.0, _itemMargin / 2, 20.0, _itemMargin / 2),
        child: child);

    Widget documentCardContainerListTile(SingleItem item) => padding(
          _borderlessCards
              ? Column(
                  children: [
                    DocumentCardContainer.borderless(
                      item: item,
                      showFavoriteButton: _showFavoriteButton,
                    ),
                    Divider(
                      color: theme.groupingColor,
                      thickness: 1,
                      indent: 64,
                      height: _itemMargin,
                    ),
                  ],
                )
              : DocumentCardContainer(
                  item: item,
                  showFavoriteButton: _showFavoriteButton,
                ),
        );

    return SliverPrototypeExtentList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          ref.watch(Providers.singleItemControllerProvider(_items[index].id));
          return documentCardContainerListTile(_items[index]);
        },
        childCount: _items.length,
      ),
      prototypeItem: documentCardContainerListTile(SingleItem.prototype()),
    );
  }
}
