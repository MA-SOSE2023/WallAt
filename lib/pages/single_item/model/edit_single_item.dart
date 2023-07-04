import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'item_event.dart';
import 'single_item.dart';

part 'edit_single_item.freezed.dart';

@freezed
class EditSingleItem with _$EditSingleItem {
  const EditSingleItem._();

  factory EditSingleItem({
    required int id,
    required String title,
    required String description,
    required ImageProvider image,
    required bool isFavorite,
    required List<ItemEvent> events,
    @Default([]) List<ItemEvent> addedEvents,
    @Default([]) List<ItemEvent> deletedEvents,
  }) = _EditSingleItem;

  SingleItem toSingleItem() => SingleItem(
        id: id,
        title: title,
        description: description,
        image: image,
        isFavorite: isFavorite,
        events: events,
      );

  factory EditSingleItem.from(
    SingleItem item, {
    List<ItemEvent>? addedEvents,
    List<ItemEvent>? deletedEvents,
  }) =>
      EditSingleItem(
        id: item.id,
        title: item.title,
        description: item.description,
        image: item.image,
        isFavorite: item.isFavorite,
        events: item.events,
        addedEvents: addedEvents ?? [],
        deletedEvents: deletedEvents ?? [],
      );
}
