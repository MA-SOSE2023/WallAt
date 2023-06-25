import 'package:device_calendar/device_calendar.dart';
import 'package:isar/isar.dart';

import '/pages/single_item/model/item_event.dart';
import '/common/services/persistence/persistence_service.dart';

class IsarItemEventDio extends ItemEventDio {
  IsarItemEventDio({required Future<Isar> db}) : _db = db;

  final Future<Isar> _db;

  @override
  Future<ItemEvent> create({required Event event, required int parentItemId}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Id id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ItemEvent> read(Id id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<List<ItemEvent>> readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<List<ItemEvent>> readAllSoon() {
    // TODO: implement readAllSoon
    throw UnimplementedError();
  }

  @override
  Future<void> update(ItemEvent item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
