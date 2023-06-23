import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder_model.freezed.dart';

@freezed
class Folder extends FolderItem with _$Folder {
  const factory Folder({
    required String id,
    required String title,
    required List<FolderItem> contents,
  }) = _Folder;
}

abstract class FolderItem {
  const FolderItem({
    required String id,
    required String title,
  });

  String get id;
  String get title;
}
