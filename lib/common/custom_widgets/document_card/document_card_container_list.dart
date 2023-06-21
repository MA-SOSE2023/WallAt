import 'package:flutter/cupertino.dart';

import 'document_card_container.dart';

class DocumentCardContainerList extends StatelessWidget {
  const DocumentCardContainerList({required itemIds, super.key})
      : _itemIds = itemIds;

  final List<String> _itemIds;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: _itemIds
            .map(
              (String id) => Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                child: DocumentCardContainer(id: id),
              ),
            )
            .toList(),
      ),
    );
  }
}
