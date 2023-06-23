import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'document_card_container.dart';
import '/pages/single_item/model/single_item.dart';

class DocumentCardContainerList extends StatelessWidget {
  const DocumentCardContainerList({
    required List<SingleItem> items,
    bool borderlessCards = true,
    double itemMargin = 16.0,
    super.key,
  })  : _items = items,
        _borderlessCards = borderlessCards,
        _itemMargin = itemMargin;

  final List<SingleItem> _items;
  final bool _borderlessCards;
  final double _itemMargin;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: _items
            .map(
              (SingleItem item) => Padding(
                padding: _borderlessCards
                    ? const EdgeInsets.all(0.0)
                    : EdgeInsets.fromLTRB(
                        20.0, _itemMargin / 2, 20.0, _itemMargin / 2),
                child: _borderlessCards
                    ? Column(
                        children: [
                          DocumentCardContainer.borderless(item: item),
                          Divider(
                            color: CupertinoDynamicColor.resolve(
                                CupertinoColors.inactiveGray, context),
                            indent: 64,
                            height: _itemMargin,
                          ),
                        ],
                      )
                    : DocumentCardContainer(item: item),
              ),
            )
            .toList(),
      ),
    );
  }
}
