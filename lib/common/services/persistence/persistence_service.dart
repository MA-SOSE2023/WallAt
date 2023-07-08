import 'dart:async';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/folders/folder_item.dart';
import '/pages/folders/folder_model.dart';
import '/pages/profiles/profile_model.dart';
import '/pages/single_item/model/single_item.dart';
import '/pages/single_item/model/item_event.dart';
import 'db_model.dart';

/// App service for accessing and modifying persistent data
class PersistenceService {
  final DbController _controller;
  final int? _selectedProfileId;

  PersistenceService({
    required DbController controller,
    int? profileId,
  })  : _controller = controller,
        _selectedProfileId = profileId;

  Future<R> _singleItemDao<R>(Future<R> Function(SingleItemDao) callback) =>
      _controller.singleItemDao.then(callback);

  Future<R> _folderDao<R>(Future<R> Function(FolderDao) callback) =>
      _controller.folderDao.then(callback);

  Future<R> _eventDao<R>(Future<R> Function(ItemEventDao) callback) =>
      _controller.eventDao.then(callback);

  Future<R> _profileDao<R>(Future<R> Function(ProfileDao) callback) =>
      _controller.profileDao.then(callback);

  // To the outside, use a constant placeholder value
  // so that providers can be created before the root folder id is known
  static int get rootFolderId => _rootFolderIdPlaceholder;
  static const int _rootFolderIdPlaceholder = -1;

  Future<int> get _defaultProfileId => _controller.defaultProfileId;

  Future<int?> get _profileId async {
    // Return null for default profile so that items of all profiles are visible
    if (_selectedProfileId == await _defaultProfileId) {
      return null;
    }
    return _selectedProfileId;
  }

  Future<int> get _realRootFolderId async =>
      _controller.rootFolderId(await _profileId ?? await _defaultProfileId);

  // ====================== CREATION ====================== //

  Future<SingleItem> createSingleItem({
    required String title,
    required String imagePath,
    String description = '',
    bool isFavorite = false,
    int? parentFolderId,
  }) async {
    final int rootId = await _realRootFolderId;
    return _singleItemDao(
      (dao) async => dao.create(
        title: title,
        imagePath: imagePath,
        description: description,
        isFavorite: isFavorite,
        parentFolderId: parentFolderId ?? rootId,
        profileId: await _profileId ?? await _defaultProfileId,
      ),
    );
  }

  Future<Folder> createFolder({
    required String title,
    int? parentFolderId,
  }) =>
      _folderDao(
        (dao) async => dao.create(
          title: title,
          parentFolderId: parentFolderId,
          profileId: await _profileId ?? await _defaultProfileId,
        ),
      );

  Future<ItemEvent> createEvent({
    required Event event,
    required int parentItemId,
  }) =>
      _eventDao(
        (dao) async => dao.create(
          event: event,
          parentItemId: parentItemId,
          profileId: await _profileId ?? await _defaultProfileId,
        ),
      );

  Future<ProfileModel> createProfile({
    required String name,
    required int selectedImageIndex,
  }) =>
      _profileDao(
        (dao) => dao.create(
          name: name,
          selectedImageIndex: selectedImageIndex,
        ),
      );

  // ====================== GETTERS ====================== //

  /// Returns the [SingleItme] with the given [itemId].
  /// Returns null if no item with the given [itemId] exists
  Future<SingleItem?> getSingleItem(int itemId) =>
      _singleItemDao((dao) => dao.read(itemId));

  Future<List<SingleItem>> getItemsMatching(String query) => _singleItemDao(
      (dao) async => dao.readAllMatching(query, await _profileId));

  Future<List<SingleItem>> getFavoriteItems() =>
      _singleItemDao((dao) async => dao.readAllFavorites(await _profileId));

  Future<List<SingleItem>> getFavoriteItemsMatching(String query) =>
      _singleItemDao(
          (dao) async => dao.readAllFavoritesMatching(query, await _profileId));

  Future<List<SingleItem>> getRecentItems() =>
      _singleItemDao((dao) async => dao.readAllRecent(15, await _profileId));

  /// Returns the [Folder] with the given [folderId].
  /// Returns null if no folder with the given [folderId] exists
  Future<Folder?> getFolder(int folderId) async {
    if (folderId == _rootFolderIdPlaceholder) {
      folderId = await _realRootFolderId;
      // Concatenate all root folders if the default profile is selected
      if (_selectedProfileId == await _defaultProfileId) {
        final List<ProfileModel> allProfiles = await getAllProfiles();
        final List<Future<Folder?>> allRootFolders = allProfiles
            .map((p) async => getFolder(await _controller.rootFolderId(p.id)))
            .toList();

        final Folder? rootFolder = await getFolder(folderId);

        return Future.wait(allRootFolders).then<Folder?>(
          (folders) => folders.fold<Folder?>(
            Folder(id: rootFolder!.id, title: rootFolder.title, contents: []),
            (previousValue, element) => previousValue?.copyWith(
              contents: [
                ...(previousValue.contents ?? []),
                ...(element?.contents ?? [])
              ],
            ),
          ),
        );
      }
    }
    return _folderDao((dao) => dao.read(folderId));
  }

  Future<Folder?> getParentFolder(FolderItem item) async {
    int? parentId = await _folderDao((dao) => dao.findItemParentId(item.id));
    if (parentId != null) {
      Future<Folder?> folder = getFolder(parentId);
      if (parentId == await _realRootFolderId) {
        return folder
            .then((folder) => folder?.copyWith(id: _rootFolderIdPlaceholder));
      }
      return folder;
    }
    return null;
  }

  Future<int?> getParentFolderId(FolderItem item) =>
      _folderDao((dao) => dao.findItemParentId(item.id));

  /// Returns the [ItemEvent] with the given [eventId].
  /// Returns null if no event with the given [eventId] exists
  Future<ItemEvent?> getEvent(int eventId) =>
      _eventDao((dao) => dao.read(eventId));

  Future<List<ItemEvent>> getAllEvents() =>
      _eventDao((dao) async => dao.readAll(await _profileId));

  Future<List<ItemEvent>> getSoonEvents() => _eventDao((dao) async =>
      dao.readAllSoon(const Duration(days: 7), await _profileId));

  Future<ProfileModel?> getProfile(int profileId) =>
      _profileDao((dao) => dao.read(profileId));

  Future<List<ProfileModel>> getAllProfiles() =>
      _profileDao((dao) => dao.readAll());

  static List<ImageProvider> get selectableProfilePictures => const [
        AssetImage('assets/dev_debug_images/mom.png'),
        AssetImage('assets/dev_debug_images/dad.png'),
        AssetImage('assets/dev_debug_images/daughter.png'),
        AssetImage('assets/dev_debug_images/son.png'),
      ];

  // ====================== SETTERS ====================== //

  Future<void> updateSingleItem(SingleItem item) =>
      _singleItemDao((dao) => dao.update(item));

  Future<void> updateSingleItemRecencyFromId(SingleItem item) =>
      updateSingleItemRecency(item.id);

  Future<void> updateSingleItemRecency(int itemId) =>
      _singleItemDao((dao) => dao.updateRecency(itemId));

  Future<void> updateFolder(Folder folder) =>
      _folderDao((dao) => dao.update(folder));

  Future<void> updateEvent(ItemEvent event) =>
      _eventDao((dao) => dao.update(event));

  Future<void> updateProfile(ProfileModel profile) =>
      _profileDao((dao) => dao.update(profile));

  Future<void> moveSingleItem(SingleItem item, Folder newParent) =>
      _singleItemDao((dao) => dao.move(item, newParent));

  Future<void> moveFolder(Folder folder, Folder newParent) =>
      _folderDao((dao) => dao.move(folder, newParent));

  // ====================== DELETION ====================== //

  Future<bool> deleteSingleItem(SingleItem item) =>
      _folderDao((dao) => dao.deleteItemFromFolder(item));

  Future<bool> deleteFolder(Folder folder) =>
      _folderDao((dao) => dao.delete(folder.id));

  Future<bool> deleteEvent(ItemEvent event) =>
      _eventDao((dao) => dao.delete(event.id));

  Future<bool> deleteProfile(ProfileModel profile) =>
      _profileDao((dao) => dao.delete(profile.id));

  Future<void> clearDb() => _controller.clearDb();
}

abstract class Dao<T> {
  Future<void> update(T item);
  Future<bool> delete(int id);
  Future<T?> read(int id);
}

abstract class SingleItemDao extends Dao<SingleItem> {
  /// Creates a new item with the given parameters.
  /// Returns a [SingleItem] with the id of the newly created item.
  Future<SingleItem> create({
    required String title,
    required String imagePath,
    required String description,
    required bool isFavorite,
    required int parentFolderId,
    required int profileId,
  });

  /// If [profileId] is null, returns all items for all profiles.
  ///
  /// If [profileId] is not null, returns all items for the given profile.
  Future<List<SingleItem>> readAll(int? profileId);

  /// If [profileId] is null, returns all items matching [query] for all profiles.
  ///
  /// If [profileId] is not null, returns all items matching [query] for the given profile.
  Future<List<SingleItem>> readAllMatching(String query, int? profileId);

  /// If [profileId] is null, returns all items marked favorite for all profiles.
  ///
  /// If [profileId] is not null, returns all items marked favorite for the given profile.
  Future<List<SingleItem>> readAllFavorites(int? profileId);

  /// If [profileId] is null, returns all items marked favorite matching [query] for all profiles.
  ///
  /// If [profileId] is not null, returns all items marked favorite matching [query] for the given profile.
  Future<List<SingleItem>> readAllFavoritesMatching(
      String query, int? profileId);
  Future<List<SingleItem>> readAllRecent(int count, int? profileId);

  /// Moves the given [item] to the given [newParent].
  Future<void> move(SingleItem item, Folder newParent);

  /// Moves the given [item] to the given [newProfile].
  Future<void> moveToProfile(SingleItem item, int newProfile);

  /// Sets the recency of the given [item] to the current time.
  Future<void> updateRecency(int id);
}

abstract class FolderDao extends Dao<Folder> {
  /// Creates a new folder with the given parameters.
  /// Returns a [Folder] with the id of the newly created folder.
  Future<Folder> create({
    required String title,
    int? parentFolderId,
    required int profileId,
  });

  /// Returns the id of the root folder for the given [profileId].
  /// If no root folder exists for the given [profileId], creates a new root folder.
  ///
  /// If [profileId] is null, the root folder for the default profile is returned.
  Future<int> createOrFindRoot(int profileId);

  /// Deletes an item from a folder.
  Future<bool> deleteItemFromFolder(SingleItem item);

  /// Moves the given [folder] to the given [newParent].
  Future<void> move(Folder folder, Folder newParent);

  /// Moves the given [folder] to the given [newProfile].
  Future<void> moveToProfile(Folder folder, int newProfile);

  /// If [profileId] is null, returns all folders for all profiles.
  ///
  /// If [profileId] is not null, returns all folders for the given profile.
  Future<List<Folder>> readAll(int? profileId);

  /// Finds the parent folder of the item with given [childId].
  Future<int?> findItemParentId(int childId);

  /// Finds the parent folder of the folder with given [childId].
  Future<int?> findFolderParentId(int childId);
}

abstract class ItemEventDao extends Dao<ItemEvent> {
  /// Creates a new event with the given parameters.
  /// Returns a [ItemEvent] with the id of the newly created event.
  Future<ItemEvent> create({
    required Event event,
    required int parentItemId,
    required int profileId,
  });

  /// If [profileId] is null, returns all events for all profiles.
  ///
  /// If [profileId] is not null, returns all events for the given profile.
  Future<List<ItemEvent>> readAll(int? profileId);

  /// If [profileId] is null, returns all events happening soon for all profiles.
  ///
  /// If [profileId] is not null, returns all events happening soon for the given profile.
  ///
  /// [soonDuration] is the time span in which events are considered to be happening soon.
  Future<List<ItemEvent>> readAllSoon(Duration soonDuration, int? profileId);
}

abstract class ProfileDao extends Dao<ProfileModel> {
  /// Creates a new profile with the given parameters.
  /// Returns a [ProfileModel] with the id of the newly created profile.
  Future<ProfileModel> create({
    required String name,
    required int selectedImageIndex,
  });

  /// Returns the id of the default profile.
  /// On first ever app start, creates a default profile and then return its id.
  Future<int> createOrFindDefault();

  /// Returns all profiles.
  Future<List<ProfileModel>> readAll();
}

typedef Db = dynamic;

abstract class DbController extends StateNotifier<DbModel> {
  DbController(DbModel state) : super(state);

  Future<void> openDb();

  Future<SingleItemDao> get singleItemDao;
  Future<FolderDao> get folderDao;
  Future<ItemEventDao> get eventDao;
  Future<ProfileDao> get profileDao;

  Future<int> rootFolderId(int profileId);
  Future<int> get defaultProfileId;

  Future<void> clearDb();
}
