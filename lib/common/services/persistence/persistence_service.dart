import 'package:device_calendar/device_calendar.dart';
import 'package:isar/isar.dart';

import 'schemas/folder_entry.dart';
import 'schemas/item_event_entry.dart';
import 'schemas/single_item_entry.dart';

import '/pages/folders/folder_model.dart';
import '/pages/single_item/model/single_item.dart';
import '/pages/single_item/model/item_event.dart';

/*
/// App service for accessing and modifying persistent data
class PersistenceService {
  PersistenceService({
    required SingleItemDio singleItemDio,
    required FolderDio folderDio,
    required EventDio eventDio,
  })  : _singleItemDio = singleItemDio,
        _folderDio = folderDio,
        _eventDio = eventDio;

  final SingleItemDio _singleItemDio;
  final FolderDio _folderDio;
  final EventDio _eventDio;

  static const Id rootFolderId = 1;

  // ====================== CREATION ====================== //

  Future<SingleItem> createSingleItem({
    required String title,
    required String imagePath,
    String description = '',
    bool isFavorite = false,
    List<ItemEvent> events = const [],
    Id? parentFolderId,
  }) =>
      _singleItemDio.create(SingleItemSchema(
        title: title,
        imagePath: imagePath,
        description: description,
        isFavorite: isFavorite,
        events: events,
        parentFolderId: parentFolderId ?? rootFolderId,
      ));

  Future<Folder> createFolder({
    required String title,
    Id? parentFolderId,
  }) =>
      _folderDio.create(FolderSchema(
        title: title,
        parentFolderId: parentFolderId ?? rootFolderId,
      ));

  Future<ItemEvent> createEvent({
    required Event event,
    required Id parentItemId,
  }) =>
      _eventDio.create(ItemEventSchema(
        event: event,
        parentItemId: parentItemId,
      ));

  // ====================== GETTERS ====================== //

  /// Returns the [SingleItme] with the given [itemId].
  /// Returns null if no item with the given [itemId] exists
  Future<SingleItem?> getSingleItem(Id itemId) => _singleItemDio.read(itemId);

  Future<List<SingleItem>> getItemsMatching(String query) =>
      _singleItemDio.readAllMatching(query);

  Future<List<SingleItem>> getFavoriteItems() =>
      _singleItemDio.readAllFavorites();

  Future<List<SingleItem>> getFavoriteItemsMatching(String query) =>
      _singleItemDio.readAllFavoritesMatching(query);

  Future<List<SingleItem>> getRecentItems() => _singleItemDio.readAllRecent();

  /// Returns the [Folder] with the given [folderId].
  /// Returns null if no folder with the given [folderId] exists
  Future<Folder?> getFolder(Id folderId) => _folderDio.read(folderId);

  /// Returns the [ItemEvent] with the given [eventId].
  /// Returns null if no event with the given [eventId] exists
  Future<ItemEvent?> getEvent(Id eventId) => _eventDio.read(eventId);

  Future<List<ItemEvent>> getAllEvents() => _eventDio.readAll();

  Future<List<ItemEvent>> getSoonEvents() => _eventDio.readAllSoon();

  // ====================== SETTERS ====================== //

  Future<void> updateSingleItem(SingleItem item) => _singleItemDio.update(item);

  Future<void> updateFolder(Folder folder) => _folderDio.update(folder);

  Future<void> updateEvent(ItemEvent event) => _eventDio.update(event);

  // ====================== DELETION ====================== //

  Future<void> deleteSingleItem(SingleItem item) =>
      _singleItemDio.delete(int.parse(item.id));

  Future<void> deleteFolder(Folder folder) async =>
      _folderDio.delete(int.parse(folder.id));

  Future<void> deleteEvent(ItemEvent event) async =>
      _eventDio.delete(int.parse(event.id));
}

abstract class Dio<T, R> {
  Future<R> create(T item);
  Future<void> update(R item);
  Future<void> delete(Id id);
  Future<R> read(Id id);
}

abstract class SingleItemDio extends Dio<SingleItemEntry, SingleItem> {
  Future<List<SingleItem>> readAll();
  Future<List<SingleItem>> readAllMatching(String query);
  Future<List<SingleItem>> readAllFavorites();
  Future<List<SingleItem>> readAllFavoritesMatching(String query);
  Future<List<SingleItem>> readAllRecent();
}

abstract class FolderDio extends Dio<FolderEntry, Folder> {
  Future<List<Folder>> readAll();
}

abstract class EventDio extends Dio<ItemEventEntry, ItemEvent> {
  Future<List<ItemEvent>> readAll();
  Future<List<ItemEvent>> readAllSoon();
}
*/