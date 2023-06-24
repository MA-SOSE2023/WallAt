import 'package:freezed_annotation/freezed_annotation.dart';

import 'item_event.dart';
import '/pages/folders/folder_item.dart';
import '/pages/folders/folder_model.dart';

part 'single_item.freezed.dart';

@freezed
class SingleItem with _$SingleItem implements FolderItem {
  SingleItem._();

  @Implements<FolderItem>()
  factory SingleItem({
    required String id,
    required String title,
    required String description,
    required String image,
    required bool isFavorite,
    required List<ItemEvent> events,
    DateTime? currentSelectedDate,
  }) = _SingleItem;

  @override
  SingleItem? get maybeItem => this;
  @override
  Folder? get maybeFolder => null;
  @override
  SingleItem get item => this;
  @override
  Folder get folder => throw UnsupportedError('Not a folder');

  @override
  bool get isLeaf => true;
  @override
  bool get isFolder => false;

  @override
  List<FolderItem> get contents => throw UnsupportedError('Not a folder');
}
