import 'package:isar/isar.dart';

import 'isar_single_item.dart';
import '/pages/folders/folder_model.dart';

part 'isar_folder.g.dart';

@collection
class IsarFolder {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String title;

  bool isRoot = false;

  IsarLinks<IsarFolder> folders = IsarLinks<IsarFolder>();

  @Backlink(to: "folders")
  IsarLink<IsarFolder> parentFolder = IsarLink<IsarFolder>();

  IsarLinks<IsarSingleItem> items = IsarLinks<IsarSingleItem>();

  Folder toFolder() => Folder(
        id: id,
        title: title,
        contents: [
          ...folders
              .map((isarFolder) => Folder(
                    id: isarFolder.id,
                    title: isarFolder.title,
                    contents: null,
                  ))
              .toList(),
          ...items.map((isarItem) => isarItem.toSingleItem()).toList(),
        ],
      );
}
