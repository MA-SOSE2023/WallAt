import 'package:device_calendar/device_calendar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

import 'isar/schemas/isar_folder.dart';
import 'isar/schemas/isar_single_item.dart';
import 'isar/schemas/isar_item_event.dart';

import '/pages/folders/folder_model.dart';
import '/pages/single_item/model/single_item.dart';
import '/pages/single_item/model/item_event.dart';

/// App service for accessing and modifying persistent data
class PersistenceService {
  late Future<Isar> db;

  late final SingleItemDio _singleItemDio;
  late final FolderDio _folderDio;
  late final ItemEventDio _eventDio;

  PersistenceService({
    required SingleItemDio singleItemDio,
    required FolderDio folderDio,
    required ItemEventDio eventDio,
  }) {
    _singleItemDio = singleItemDio;
    _folderDio = folderDio;
    _eventDio = eventDio;
    db = openDb();
  }

  Future<Isar> openDb() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [IsarSingleItemSchema, IsarFolderSchema, IsarItemEventSchema],
        directory: (await getApplicationDocumentsDirectory()).path,
        inspector: true, // Inspector allows real-time insight into the database
        // we might want to disable this in production
      );
    }

    return Future.value(Isar.getInstance());
  }

  static const int rootFolderId = 0;

  // ====================== CREATION ====================== //

  Future<SingleItem> createSingleItem({
    required String title,
    required String imagePath,
    String description = '',
    bool isFavorite = false,
    int? parentFolderId,
  }) =>
      _singleItemDio.create(
        title: title,
        imagePath: imagePath,
        description: description,
        isFavorite: isFavorite,
        parentFolderId: parentFolderId ?? rootFolderId,
      );

  Future<Folder> createFolder({
    required String title,
    int? parentFolderId,
  }) =>
      _folderDio.create(
        title: title,
        parentFolderId: parentFolderId ?? rootFolderId,
      );

  Future<ItemEvent> createEvent({
    required Event event,
    required int parentItemId,
  }) =>
      _eventDio.create(
        event: event,
        parentItemId: parentItemId,
      );

  // ====================== GETTERS ====================== //

  /// Returns the [SingleItme] with the given [itemId].
  /// Returns null if no item with the given [itemId] exists
  Future<SingleItem?> getSingleItem(int itemId) => _singleItemDio.read(itemId);

  Future<List<SingleItem>> getItemsMatching(String query) =>
      _singleItemDio.readAllMatching(query);

  Future<List<SingleItem>> getFavoriteItems() =>
      _singleItemDio.readAllFavorites();

  Future<List<SingleItem>> getFavoriteItemsMatching(String query) =>
      _singleItemDio.readAllFavoritesMatching(query);

  Future<List<SingleItem>> getRecentItems() => _singleItemDio.readAllRecent();

  /// Returns the [Folder] with the given [folderId].
  /// Returns null if no folder with the given [folderId] exists
  Future<Folder?> getFolder(int folderId) => _folderDio.read(folderId);

  /// Returns the [ItemEvent] with the given [eventId].
  /// Returns null if no event with the given [eventId] exists
  Future<ItemEvent?> getEvent(int eventId) => _eventDio.read(eventId);

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

abstract class Dio<T> {
  Future<void> update(T item);
  Future<void> delete(Id id);
  Future<T> read(Id id);
}

abstract class SingleItemDio extends Dio<SingleItem> {
  Future<SingleItem> create({
    required String title,
    required String imagePath,
    required String description,
    required bool isFavorite,
    required int parentFolderId,
  });

  Future<List<SingleItem>> readAll();
  Future<List<SingleItem>> readAllMatching(String query);
  Future<List<SingleItem>> readAllFavorites();
  Future<List<SingleItem>> readAllFavoritesMatching(String query);
  Future<List<SingleItem>> readAllRecent();
}

abstract class FolderDio extends Dio<Folder> {
  Future<int> get rootFolderId;

  Future<Folder> create({
    required String title,
    required int parentFolderId,
  });
  Future<List<Folder>> readAll();
}

abstract class ItemEventDio extends Dio<ItemEvent> {
  Future<ItemEvent> create({
    required Event event,
    required int parentItemId,
  });
  Future<List<ItemEvent>> readAll();
  Future<List<ItemEvent>> readAllSoon();
}
