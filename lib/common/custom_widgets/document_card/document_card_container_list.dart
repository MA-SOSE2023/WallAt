import 'package:flutter/cupertino.dart';

import 'document_card_container.dart';
import '/pages/single_item/model/single_item.dart';

class DocumentCardContainerList extends StatelessWidget {
  const DocumentCardContainerList({required List<SingleItem> items, super.key})
      : _items = items;

  final List<SingleItem> _items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: _items
            .map(
              (SingleItem item) => Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                child: DocumentCardContainer(item: item),
              ),
            )
            .toList(),
      ),
    );
  }
}
