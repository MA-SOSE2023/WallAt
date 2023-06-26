import 'package:isar/isar.dart';

import 'isar_folder.dart';
import 'isar_item_event.dart';

part 'isar_single_item.g.dart';

@collection
class IsarSingleItem {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String title;

  late String imagePath;

  late String description;

  late bool isFavorite;

  @Backlink(to: "items")
  final parentFolder = IsarLink<IsarFolder>();

  final events = IsarLinks<IsarItemEvent>();
}
