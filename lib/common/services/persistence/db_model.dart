import 'package:freezed_annotation/freezed_annotation.dart';

import 'persistence_service.dart';

part 'db_model.freezed.dart';

@freezed
class DbModel with _$DbModel {
  factory DbModel({
    Db? db,
    FolderDio? folderDio,
    SingleItemDio? singleItemDio,
    ItemEventDio? eventDio,
    int? rootFolderId,
  }) = _DbModel;
}
