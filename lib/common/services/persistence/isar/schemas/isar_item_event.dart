import 'package:isar/isar.dart';

import 'isar_single_item.dart';

part 'isar_item_event.g.dart';

@collection
class IsarItemEvent {
  Id id = Isar.autoIncrement;

  late String calendarId;

  String? eventId;

  late String title;

  late String description;

  late DateTime start;

  late DateTime end;

  final parentItem = IsarLink<IsarSingleItem>();
}
