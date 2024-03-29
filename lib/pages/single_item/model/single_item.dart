import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'item_event.dart';
import '/pages/folders/folder_item.dart';
import '/pages/single_item/single_item_view.dart';
import '/common/localization/language.dart';

part 'single_item.freezed.dart';

@freezed
class SingleItem extends FolderItem with _$SingleItem {
  SingleItem._()
      : super(
          isLeaf: true,
        ) {
    maybeItem = this;
    maybeFolder = null;
  }

  @Implements<FolderItem>()
  factory SingleItem({
    required int id,
    required String title,
    required String description,
    required ImageProvider image,
    required bool isFavorite,
    required List<ItemEvent> events,
  }) = _SingleItem;

  factory SingleItem.prototype() => SingleItem(
        id: -1,
        title: 'prototype',
        description: 'prototype',
        image: const AssetImage('assets/dev_debug_images/example_document.png'),
        isFavorite: false,
        events: [],
      );

  factory SingleItem.placeholder({
    required int id,
    ImageProvider? image,
  }) =>
      SingleItem(
        id: id,
        title: '',
        description: '',
        image: image ??
            const AssetImage('assets/dev_debug_images/example_document.png'),
        isFavorite: false,
        events: [],
      );

  factory SingleItem.error(Language language) => SingleItem(
        id: -1,
        title: language.errLoadItem,
        description: language.errGenericLoad,
        image: const AssetImage('assets/dev_debug_images/hampter1.jpg'),
        isFavorite: false,
        events: [],
      );

  @override
  get thumbnail => Image(image: image);

  @override
  get heroTag => singleItemHeroTag('$id');

  @override
  List<FolderItem> get contents => throw UnsupportedError('Not a folder');
}
