import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'item_event.dart';
import '/pages/folders/folder_item.dart';
import '/pages/folders/folder_model.dart';

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
    required String id,
    required String title,
    required String description,
    required ImageProvider image,
    required bool isFavorite,
    required List<ItemEvent> events,
    DateTime? currentSelectedDate,
  }) = _SingleItem;

  factory SingleItem.prototype() => SingleItem(
        id: 'prototype',
        title: 'prototype',
        description: 'prototype',
        image: const AssetImage('assets/dev_debug_images/hampter1.jpg'),
        isFavorite: false,
        events: [],
      );

  @override
  get thumbnail => Image(image: image);

  @override
  List<FolderItem> get contents => throw UnsupportedError('Not a folder');
}
