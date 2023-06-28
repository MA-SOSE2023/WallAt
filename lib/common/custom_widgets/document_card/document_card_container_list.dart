import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/custom_widgets/all_custom_widgets.dart'
    show DocumentCardContainer;

import '/pages/single_item/model/single_item.dart';

class DocumentCardContainerList extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
                      itemId: item.id,
                      showFavoriteButton: _showFavoriteButton,
                    ),
                    Divider(
                      color: CupertinoDynamicColor.resolve(
                          CupertinoColors.inactiveGray, context),
                      thickness: 1,
                      indent: 64,
                      height: _itemMargin,
                    ),
                  ],
                )
              : DocumentCardContainer(
                  itemId: item.id,
                  showFavoriteButton: _showFavoriteButton,
                ),
        );

    return SliverPrototypeExtentList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) =>
            documentCardContainerListTile(_items[index]),
        childCount: _items.length,
      ),
      prototypeItem: documentCardContainerListTile(SingleItem.prototype()),
    );
  }
}
