import 'package:freezed_annotation/freezed_annotation.dart';

import 'persistence_service.dart';

part 'db_model.freezed.dart';

@freezed
class DbModel with _$DbModel {
  factory DbModel({
    Future<Db>? db,
    FolderDao? folderDao,
    SingleItemDao? singleItemDao,
    ItemEventDao? eventDao,
    int? rootFolderId,
  }) = _DbModel;
}
