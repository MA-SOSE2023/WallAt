import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'folder_item.dart';
import '/pages/single_item/model/single_item.dart';

part 'folder_model.freezed.dart';

@freezed
class Folder with _$Folder implements FolderItem {
  Folder._();

  @Implements<FolderItem>()
  factory Folder({
    required String id,
    required String title,
    required List<FolderItem> contents,
  }) = _Folder;

  @override
  SingleItem? get maybeItem => null;
  @override
  Folder? get maybeFolder => this;
  @override
  SingleItem get item => throw UnsupportedError('Not an item');
  @override
  Folder get folder => this;

  @override
  bool get isLeaf => false;
  @override
  bool get isFolder => true;

  @override
  get thumbnail => const Icon(CupertinoIcons.folder);
}
