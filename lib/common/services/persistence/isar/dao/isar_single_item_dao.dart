import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';

import '/pages/folders/folder_model.dart';
import '/pages/single_item/model/single_item.dart';
import '/common/services/persistence/persistence_service.dart';
import '/common/services/persistence/isar/schemas/isar_folder.dart';
import '/common/services/persistence/isar/schemas/isar_item_event.dart';
import '/common/services/persistence/isar/schemas/isar_single_item.dart';
import '/common/services/persistence/isar/schemas/isar_profile.dart';

class IsarSingleItemDao extends SingleItemDao {
  IsarSingleItemDao({required Isar db}) : _isar = db;

  final Isar _isar;

  @override
  Future<SingleItem> create({
    required String title,
    required String imagePath,
    required String description,
    required bool isFavorite,
    required int parentFolderId,
    required int profileId,
  }) async {
    final IsarFolder? parentFolder =
        await _isarReadParentFolder(parentFolderId);
    final IsarProfile? profile = await _isar.isarProfiles.get(profileId);
    final Id createdItemId = await _isar.writeTxnSync(
      () => _isar.isarSingleItems.putSync(
        IsarSingleItem()
          ..title = title
          ..imagePath = imagePath
          ..description = description
          ..isFavorite = isFavorite
          ..parentFolder.value = parentFolder
          ..profile.value = profile,
      ),
    );
    return SingleItem(
      id: createdItemId,
      title: title,
      image: FileImage(File(imagePath)),
      description: description,
      isFavorite: isFavorite,
      events: [],
    );
  }

  Future<IsarFolder?> _isarReadParentFolder(int id) =>
      _isar.isarFolders.get(id);

  @override
  Future<bool> delete(Id id) =>
      _isar.writeTxn(() => _isar.isarSingleItems.delete(id));

  @override
  Future<SingleItem?> read(Id id) => _isar.isarSingleItems
      .get(id)
      .then((isarItem) => isarItem?.toSingleItem());

  @override
  Future<List<SingleItem>> readAll(int? profileId) {
    if (profileId != null) {
      return _isar.isarSingleItems
          .filter()
          .profile((p) => p.idEqualTo(profileId))
          .findAll()
          .then((isarItems) =>
              isarItems.map((isarItem) => isarItem.toSingleItem()).toList());
    }
    // Return all items from all profiles
    return _isar.isarSingleItems.where().findAll().then((isarItems) =>
        isarItems.map((isarItem) => isarItem.toSingleItem()).toList());
  }

  @override
  Future<List<SingleItem>> readAllFavorites(int? profileId) {
    if (profileId != null) {
      return _isar.isarSingleItems
          .filter()
          .isFavoriteEqualTo(true)
          .profile((p) => p.idEqualTo(profileId))
          .findAll()
          .then((isarItems) =>
              isarItems.map((isarItem) => isarItem.toSingleItem()).toList());
    }
    return _isar.isarSingleItems
        .filter()
        .isFavoriteEqualTo(true)
        .findAll()
        .then((isarItems) =>
            isarItems.map((isarItem) => isarItem.toSingleItem()).toList());
  }

  @override
  Future<List<SingleItem>> readAllFavoritesMatching(
      String query, int? profileId) {
    if (profileId != null) {
      return _isar.isarSingleItems
          .filter()
          .isFavoriteEqualTo(true)
          .titleMatches(query)
          .profile((p) => p.idEqualTo(profileId))
          .findAll()
          .then((isarItems) =>
              isarItems.map((isarItem) => isarItem.toSingleItem()).toList());
    }
    return _isar.isarSingleItems
        .filter()
        .isFavoriteEqualTo(true)
        .titleMatches(query)
        .findAll()
        .then((isarItems) =>
            isarItems.map((isarItem) => isarItem.toSingleItem()).toList());
  }

  @override
  Future<List<SingleItem>> readAllMatching(String query, int? profileId) {
    if (profileId != null) {
      return _isar.isarSingleItems
          .filter()
          .titleMatches(query)
          .profile((p) => p.idEqualTo(profileId))
          .findAll()
          .then((isarItems) =>
              isarItems.map((isarItem) => isarItem.toSingleItem()).toList());
    }
    return _isar.isarSingleItems.filter().titleMatches(query).findAll().then(
        (isarItems) =>
            isarItems.map((isarItem) => isarItem.toSingleItem()).toList());
  }

  @override
  Future<List<SingleItem>> readAllRecent(int count, int? profileId) {
    if (profileId != null) {
      return _isar.isarSingleItems
          .filter()
          .profile((p) => p.idEqualTo(profileId))
          .sortByLastAccessedOrModifiedDesc()
          .limit(count)
          .findAll()
          .then((isarItems) =>
              isarItems.map((isarItem) => isarItem.toSingleItem()).toList());
    }
    return _isar.isarSingleItems
        .where()
        .sortByLastAccessedOrModifiedDesc()
        .limit(count)
        .findAll()
        .then((isarItems) =>
            isarItems.map((isarItem) => isarItem.toSingleItem()).toList());
  }

  @override
  Future<void> update(SingleItem item) async {
    final IsarSingleItem? isarItem = await _isar.isarSingleItems.get(item.id);
    if (isarItem != null) {
      final existingEventIds = isarItem.events.map((event) => event.id);
      isarItem
        ..title = item.title
        ..imagePath = (item.image as FileImage).file.path
        ..description = item.description
        ..isFavorite = item.isFavorite
        ..events.addAll(item.events
            .where((event) => !(existingEventIds.contains(event.id)))
            .map(
              (event) => IsarItemEvent()
                ..title = event.event.title ?? ''
                ..description = event.event.description ?? ''
                ..start = event.event.start!
                ..end = event.event.end!
                ..parentItem.value = isarItem,
            ));
      _isar.writeTxnSync(() => _isar.isarSingleItems.putSync(isarItem));
    }
  }

  @override
  Future<void> updateRecency(int id) => _isar.isarSingleItems.get(id).then(
        (item) {
          if (item != null) {
            _isar.writeTxnSync(() => _isar.isarSingleItems
                .putSync(item..lastAccessedOrModified = DateTime.now()));
          }
        },
      );

  @override
  Future<void> move(SingleItem item, Folder newParent) =>
      _isar.isarSingleItems.get(item.id).then((isarItem) {
        if (isarItem != null) {
          _isar.writeTxnSync(() => _isar.isarSingleItems.putSync(isarItem
            ..parentFolder.value = _isar.isarFolders.getSync(newParent.id)));
        }
      });

  @override
  Future<void> moveToProfile(SingleItem item, int newProfile) async {
    final IsarSingleItem? isarItem = await _isar.isarSingleItems.get(item.id);
    final IsarProfile? profile = await _isar.isarProfiles.get(newProfile);
    if (isarItem != null && profile != null) {
      _isar.writeTxnSync(() =>
          _isar.isarSingleItems.putSync(isarItem..profile.value = profile));
    }
  }
}
