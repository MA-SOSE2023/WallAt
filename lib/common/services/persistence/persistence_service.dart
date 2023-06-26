import 'package:device_calendar/device_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/folders/folder_model.dart';
import '/pages/single_item/model/single_item.dart';
import '/pages/single_item/model/item_event.dart';
import 'db_model.dart';

/// App service for accessing and modifying persistent data
class PersistenceService {
  final DbController _controller;

  PersistenceService({
    required DbController controller,
  }) : _controller = controller;

  Future<R> _singleItemDio<R>(Future<R> Function(SingleItemDio) callback) =>
      _controller.singleItemDio.then(callback);

  Future<R> _folderDio<R>(Future<R> Function(FolderDio) callback) =>
      _controller.folderDio.then(callback);

  Future<R> _eventDio<R>(Future<R> Function(ItemEventDio) callback) =>
      _controller.eventDio.then(callback);

  // ====================== CREATION ====================== //

  Future<SingleItem> createSingleItem({
    required String title,
    required String imagePath,
    String description = '',
    bool isFavorite = false,
    int? parentFolderId,
  }) =>
      _controller.rootFolderId.then(
        (rootId) => _singleItemDio(
          (dio) => dio.create(
            title: title,
            imagePath: imagePath,
            description: description,
            isFavorite: isFavorite,
            parentFolderId: parentFolderId ?? rootId,
          ),
        ),
      );

  Future<Folder> createFolder({
    required String title,
    int? parentFolderId,
  }) =>
      _folderDio(
        (dio) => dio.create(
          title: title,
          parentFolderId: parentFolderId,
        ),
      );

  Future<ItemEvent> createEvent({
    required Event event,
    required int parentItemId,
  }) =>
      _eventDio(
        (dio) => dio.create(
          event: event,
          parentItemId: parentItemId,
        ),
      );

  // ====================== GETTERS ====================== //

  /// Returns the [SingleItme] with the given [itemId].
  /// Returns null if no item with the given [itemId] exists
  Future<SingleItem?> getSingleItem(int itemId) =>
      _singleItemDio((dio) => dio.read(itemId));

  Future<List<SingleItem>> getItemsMatching(String query) =>
      _singleItemDio((dio) => dio.readAllMatching(query));

  Future<List<SingleItem>> getFavoriteItems() =>
      _singleItemDio((dio) => dio.readAllFavorites());

  Future<List<SingleItem>> getFavoriteItemsMatching(String query) =>
      _singleItemDio((dio) => dio.readAllFavoritesMatching(query));

  Future<List<SingleItem>> getRecentItems() =>
      _singleItemDio((dio) => dio.readAllRecent());

  /// Returns the [Folder] with the given [folderId].
  /// Returns null if no folder with the given [folderId] exists
  Future<Folder?> getFolder(int folderId) =>
      _folderDio((dio) => dio.read(folderId));

  /// Returns the [ItemEvent] with the given [eventId].
  /// Returns null if no event with the given [eventId] exists
  Future<ItemEvent?> getEvent(int eventId) =>
      _eventDio((dio) => dio.read(eventId));

  Future<List<ItemEvent>> getAllEvents() => _eventDio((dio) => dio.readAll());

  Future<List<ItemEvent>> getSoonEvents() =>
      _eventDio((dio) => dio.readAllSoon(const Duration(days: 7)));

  // ====================== SETTERS ====================== //

  Future<void> updateSingleItem(SingleItem item) =>
      _singleItemDio((dio) => dio.update(item));

  Future<void> updateFolder(Folder folder) =>
      _folderDio((dio) => dio.update(folder));

  Future<void> updateEvent(ItemEvent event) =>
      _eventDio((dio) => dio.update(event));

  // ====================== DELETION ====================== //

  Future<void> deleteSingleItem(SingleItem item) =>
      _singleItemDio((dio) => dio.delete(item.id));

  Future<void> deleteFolder(Folder folder) =>
      _folderDio((dio) => dio.delete(folder.id));

  Future<void> deleteEvent(ItemEvent event) =>
      _eventDio((dio) => dio.delete(event.id));
}

abstract class Dio<T> {
  Future<void> update(T item);
  Future<bool> delete(int id);
  Future<T?> read(int id);
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
  Future<Folder> create({
    required String title,
    int? parentFolderId,
  });
  Future<int> createOrFindRoot();
  Future<void> move(Folder folder, Folder newParent);
  Future<List<Folder>> readAll();
}

abstract class ItemEventDio extends Dio<ItemEvent> {
  Future<ItemEvent> create({
    required Event event,
    required int parentItemId,
  });
  Future<List<ItemEvent>> readAll();
  Future<List<ItemEvent>> readAllSoon(Duration soonDuration);
}

typedef Db = Future<dynamic>;

abstract class DbController extends StateNotifier<DbModel> {
  DbController(DbModel state) : super(state);

  Future<void> openDb();

  Future<SingleItemDio> get singleItemDio;
  Future<FolderDio> get folderDio;
  Future<ItemEventDio> get eventDio;

  Future<int> get rootFolderId;
}
