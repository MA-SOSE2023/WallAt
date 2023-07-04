import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/common/utils/external_resource_mixin.dart';
import 'folder_item.dart';
part 'folder_model.freezed.dart';

@freezed
class Folder extends FolderItem with _$Folder, ExternalResource {
  Folder._()
      : super(
          isLeaf: false,
          maybeItem: null,
        ) {
    maybeFolder = this;
  }

  @Implements<FolderItem>()
  factory Folder({
    /// To be used when fetching a folder from database
    @Default(false) bool isLoading,

    /// Inicates if an error occured while fetching the folder
    @Default(false) bool hasError,
    required int id,
    required String title,
    required List<FolderItem>? contents,
  }) = _Folder;

  factory Folder.loading({required int id}) => Folder(
        isLoading: true,
        id: id,
        title: 'Folders',
        contents: [],
      );

  @override
  get thumbnail => const Icon(CupertinoIcons.folder);
}
