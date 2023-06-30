import 'package:device_calendar/device_calendar.dart';
import 'package:gruppe4/common/services/persistence/isar/schemas/isar_single_item.dart';
import 'package:isar/isar.dart';

import '/pages/single_item/model/item_event.dart';
import '/common/services/persistence/isar/schemas/isar_item_event.dart';
import '/common/services/persistence/persistence_service.dart';

class IsarItemEventDao extends ItemEventDao {
  IsarItemEventDao({required Future<Isar> db}) : _db = db;

  final Future<Isar> _db;

  @override
  Future<ItemEvent> create({required Event event, required int parentItemId}) =>
      _db.then(
        (isar) => isar.writeTxnSync(
          () => _isarReadParent(parentItemId).then(
            (parentItem) {
              parentItem!;
              Id createdEvent = isar.isarItemEvents.putSync(IsarItemEvent()
                ..title = event.title ?? ''
                ..calendarId = event.calendarId
                ..description = event.description ?? ''
                ..start = event.start!
                ..end = event.end!
                ..parentItem.value = parentItem);
              return ItemEvent(
                id: createdEvent,
                event: event,
                parentId: parentItemId,
              );
            },
          ),
        ),
      );

  Future<IsarItemEvent?> _isarRead(int id) =>
      _db.then((isar) => isar.isarItemEvents.get(id));

  Future<IsarSingleItem?> _isarReadParent(int id) =>
      _db.then((isar) => isar.isarSingleItems.get(id));

  @override
  Future<bool> delete(Id id) => _db.then(
      (isar) => isar.writeTxnSync(() => isar.isarItemEvents.deleteSync(id)));

  @override
  Future<ItemEvent?> read(Id id) =>
      _isarRead(id).then((isarEvent) => isarEvent?.toItemEvent());

  @override
  Future<List<ItemEvent>> readAll() => _db.then((isar) => isar.isarItemEvents
      .where()
      .findAll()
      .then((isarEvents) =>
          isarEvents.map((isarEvent) => isarEvent.toItemEvent()).toList()));

  @override
  Future<List<ItemEvent>> readAllSoon(Duration soonDuration) =>
      _db.then((isar) => isar.isarItemEvents
          .filter()
          .startGreaterThan(DateTime.now())
          .endLessThan(DateTime.now().add(soonDuration))
          .findAll()
          .then((isarEvents) =>
              isarEvents.map((isarEvent) => isarEvent.toItemEvent()).toList()));

  @override
  Future<void> update(ItemEvent item) => _isarRead(item.id).then((isarEvent) {
        if (isarEvent != null) {
          _db.then((isar) =>
              isar.writeTxnSync(() => isar.isarItemEvents.put(isarEvent
                ..title = item.event.title ?? ''
                ..description = item.event.description ?? ''
                ..start = item.event.start!
                ..end = item.event.end!)));
        }
      });
}
