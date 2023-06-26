import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'folder_item.dart';
part 'folder_model.freezed.dart';

@freezed
class Folder extends FolderItem with _$Folder {
  Folder._()
      : super(
          isLeaf: false,
        ) {
    maybeItem = null;
    maybeFolder = this;
  }

  @Implements<FolderItem>()
  factory Folder({
    required int id,
    required String title,
    required List<FolderItem>? contents,
  }) = _Folder;

  @override
  get thumbnail => const Icon(CupertinoIcons.folder);
}
