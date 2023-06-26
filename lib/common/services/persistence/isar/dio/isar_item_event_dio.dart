import 'package:device_calendar/device_calendar.dart';
import 'package:gruppe4/common/services/persistence/isar/schemas/isar_single_item.dart';
import 'package:isar/isar.dart';

import '/pages/single_item/model/item_event.dart';
import '/common/services/persistence/isar/schemas/isar_item_event.dart';
import '/common/services/persistence/persistence_service.dart';

class IsarItemEventDio extends ItemEventDio {
  IsarItemEventDio({required Future<Isar> db}) : _db = db;

  final Future<Isar> _db;

  @override
  Future<ItemEvent> create(
      {required Event event, required int parentItemId}) async {
    final isar = await _db;
    return isar.writeTxnSync(() async {
      Id createdEvent = isar.isarItemEvents.putSync(IsarItemEvent()
        ..title = event.title ?? ''
        ..description = event.description ?? ''
        ..start = event.start!
        ..end = event.end!
        ..parentItem.value = (await _isarReadParent(parentItemId))!);
      return ItemEvent(
        id: createdEvent,
        event: event,
        parentId: parentItemId,
      );
    });
  }

  Future<IsarItemEvent?> _isarRead(int id) async {
    final isar = await _db;
    return isar.isarItemEvents.get(id);
  }

  Future<IsarSingleItem?> _isarReadParent(int id) async {
    final isar = await _db;
    return isar.isarSingleItems.get(id);
  }

  @override
  Future<bool> delete(Id id) async {
    final isar = await _db;
    return isar.isarItemEvents.delete(id);
  }

  @override
  Future<ItemEvent?> read(Id id) async {
    final isarEvent = _isarRead(id);
    return isarEvent.then((isarEvent) => isarEvent?.toItemEvent());
  }

  @override
  Future<List<ItemEvent>> readAll() async {
    final isar = await _db;
    return isar.isarItemEvents.where().findAll().then((isarEvents) =>
        isarEvents.map((isarEvent) => isarEvent.toItemEvent()).toList());
  }

  @override
  Future<List<ItemEvent>> readAllSoon(Duration soonDuration) async {
    final isar = await _db;
    return isar.isarItemEvents
        .filter()
        .startGreaterThan(DateTime.now())
        .endLessThan(DateTime.now().add(soonDuration))
        .findAll()
        .then((isarEvents) =>
            isarEvents.map((isarEvent) => isarEvent.toItemEvent()).toList());
  }

  @override
  Future<void> update(ItemEvent item) async {
    final isar = await _db;
    IsarItemEvent? isarEvent = await _isarRead(item.id);
    if (isarEvent != null) {
      isar.isarItemEvents.put(isarEvent
        ..title = item.event.title ?? ''
        ..description = item.event.description ?? ''
        ..start = item.event.start!
        ..end = item.event.end!);
    }
  }
}
