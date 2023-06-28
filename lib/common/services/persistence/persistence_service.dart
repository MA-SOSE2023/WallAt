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

  Future<R> _singleItemDao<R>(Future<R> Function(SingleItemDao) callback) =>
      _controller.singleItemDio.then(callback);

  Future<R> _folderDao<R>(Future<R> Function(FolderDao) callback) =>
      _controller.folderDio.then(callback);

  Future<R> _eventDao<R>(Future<R> Function(ItemEventDao) callback) =>
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
        (rootId) => _singleItemDao(
          (dao) => dao.create(
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
      _folderDao(
        (dao) => dao.create(
          title: title,
          parentFolderId: parentFolderId,
        ),
      );

  Future<ItemEvent> createEvent({
    required Event event,
    required int parentItemId,
  }) =>
      _eventDao(
        (dao) => dao.create(
          event: event,
          parentItemId: parentItemId,
        ),
      );

  // ====================== GETTERS ====================== //

  /// Returns the [SingleItme] with the given [itemId].
  /// Returns null if no item with the given [itemId] exists
  Future<SingleItem?> getSingleItem(int itemId) =>
      _singleItemDao((dao) => dao.read(itemId));

  Future<List<SingleItem>> getItemsMatching(String query) =>
      _singleItemDao((dao) => dao.readAllMatching(query));

  Future<List<SingleItem>> getFavoriteItems() =>
      _singleItemDao((dao) => dao.readAllFavorites());

  Future<List<SingleItem>> getFavoriteItemsMatching(String query) =>
      _singleItemDao((dao) => dao.readAllFavoritesMatching(query));

  Future<List<SingleItem>> getRecentItems() =>
      _singleItemDao((dao) => dao.readAllRecent());

  /// Returns the [Folder] with the given [folderId].
  /// Returns null if no folder with the given [folderId] exists
  Future<Folder?> getFolder(int folderId) =>
      _folderDao((dao) => dao.read(folderId));

  /// Returns the [ItemEvent] with the given [eventId].
  /// Returns null if no event with the given [eventId] exists
  Future<ItemEvent?> getEvent(int eventId) =>
      _eventDao((dao) => dao.read(eventId));

  Future<List<ItemEvent>> getAllEvents() => _eventDao((dao) => dao.readAll());

  Future<List<ItemEvent>> getSoonEvents() =>
      _eventDao((dao) => dao.readAllSoon(const Duration(days: 7)));

  // ====================== SETTERS ====================== //

  Future<void> updateSingleItem(SingleItem item) =>
      _singleItemDao((dao) => dao.update(item));

  Future<void> updateFolder(Folder folder) =>
      _folderDao((dao) => dao.update(folder));

  Future<void> updateEvent(ItemEvent event) =>
      _eventDao((dao) => dao.update(event));

  // ====================== DELETION ====================== //

  Future<void> deleteSingleItem(SingleItem item) =>
      _singleItemDao((dao) => dao.delete(item.id));

  Future<void> deleteFolder(Folder folder) =>
      _folderDao((dao) => dao.delete(folder.id));

  Future<void> deleteEvent(ItemEvent event) =>
      _eventDao((dao) => dao.delete(event.id));
}

abstract class Dao<T> {
  Future<void> update(T item);
  Future<bool> delete(int id);
  Future<T?> read(int id);
}

abstract class SingleItemDao extends Dao<SingleItem> {
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

abstract class FolderDao extends Dao<Folder> {
  Future<Folder> create({
    required String title,
    int? parentFolderId,
  });
  Future<int> createOrFindRoot();
  Future<void> move(Folder folder, Folder newParent);
  Future<List<Folder>> readAll();
}

abstract class ItemEventDao extends Dao<ItemEvent> {
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

  Future<SingleItemDao> get singleItemDio;
  Future<FolderDao> get folderDio;
  Future<ItemEventDao> get eventDio;

  Future<int> get rootFolderId;
}
