import 'package:isar/isar.dart';

import 'isar_single_item.dart';

part 'isar_folder.g.dart';

@collection
class IsarFolder {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String title;

  IsarLinks<IsarFolder> folders = IsarLinks<IsarFolder>();

  @Backlink(to: "folders")
  IsarLink<IsarFolder> parentFolder = IsarLink<IsarFolder>();

  IsarLinks<IsarSingleItem> items = IsarLinks<IsarSingleItem>();
}
