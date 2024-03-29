import 'package:device_calendar/device_calendar.dart';
import 'package:isar/isar.dart';

import 'isar_profile.dart';
import 'isar_single_item.dart';
import '/pages/single_item/model/item_event.dart';

part 'isar_item_event.g.dart';

@collection
class IsarItemEvent {
  Id id = Isar.autoIncrement;

  String? calendarId;

  String? eventId;

  late String title;

  late String description;

  late DateTime start;

  late DateTime end;

  @Backlink(to: "events")
  final IsarLink<IsarSingleItem> parentItem = IsarLink<IsarSingleItem>();

  final IsarLink<IsarProfile> profile = IsarLink<IsarProfile>();

  ItemEvent toItemEvent() => ItemEvent(
        id: id,
        event: Event(calendarId,
            eventId: eventId,
            title: title,
            description: description,
            start: TZDateTime.from(start, local),
            end: TZDateTime.from(end, local)),
        parentId: parentItem.value!.id,
      );
}
