import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';

import '/pages/single_item/model/single_item.dart';
import '/common/services/persistence/persistence_service.dart';
import '/common/services/persistence/isar/schemas/isar_folder.dart';
import '/common/services/persistence/isar/schemas/isar_item_event.dart';
import '/common/services/persistence/isar/schemas/isar_single_item.dart';

class IsarSingleItemDio extends SingleItemDio {
  IsarSingleItemDio({required Future<Isar> db}) : _db = db;

  final Future<Isar> _db;

  Future<R> _isar<R>(Future<R> Function(Isar) callback) => _db.then(callback);

  @override
  Future<SingleItem> create(
          {required String title,
          required String imagePath,
          required String description,
          required bool isFavorite,
          required int parentFolderId}) =>
      _isar(
        (isar) => isar.writeTxnSync(
          () => _isarReadParentFolder(parentFolderId)
              .then(
                (isarParentFolder) => isar.isarSingleItems.putSync(
                  IsarSingleItem()
                    ..title = title
                    ..imagePath = imagePath
                    ..description = description
                    ..isFavorite = isFavorite
                    ..parentFolder.value = isarParentFolder,
                ),
              )
              .then(
                (createdItemId) => SingleItem(
                  id: createdItemId,
                  title: title,
                  image: FileImage(File(imagePath)),
                  description: description,
                  isFavorite: isFavorite,
                  events: [],
                ),
              ),
        ),
      );

  Future<IsarFolder?> _isarReadParentFolder(int id) =>
      _isar((isar) => isar.isarFolders.get(id));

  @override
  Future<bool> delete(Id id) =>
      _isar((isar) => isar.isarSingleItems.delete(id));

  @override
  Future<SingleItem?> read(Id id) => _isar((isar) => isar.isarSingleItems
      .get(id)
      .then((isarItem) => isarItem?.toSingleItem()));

  @override
  Future<List<SingleItem>> readAll() =>
      _isar((isar) => isar.isarSingleItems.where().findAll().then((isarItems) =>
          isarItems.map((isarItem) => isarItem.toSingleItem()).toList()));

  @override
  Future<List<SingleItem>> readAllFavorites() =>
      _isar((isar) => isar.isarSingleItems
          .filter()
          .isFavoriteEqualTo(true)
          .findAll()
          .then((isarItems) =>
              isarItems.map((isarItem) => isarItem.toSingleItem()).toList()));

  @override
  Future<List<SingleItem>> readAllFavoritesMatching(String query) =>
      _isar((isar) => isar.isarSingleItems
          .filter()
          .isFavoriteEqualTo(true)
          .titleMatches(query)
          .findAll()
          .then((isarItems) =>
              isarItems.map((isarItem) => isarItem.toSingleItem()).toList()));

  @override
  Future<List<SingleItem>> readAllMatching(String query) =>
      _isar((isar) => isar.isarSingleItems
          .filter()
          .titleMatches(query)
          .findAll()
          .then((isarItems) =>
              isarItems.map((isarItem) => isarItem.toSingleItem()).toList()));

  @override
  Future<List<SingleItem>> readAllRecent() {
    // TODO: implement readAllRecent
    // Need some sort of extra field to track recency
    // Or maybe just a DateTime of last access
    throw UnimplementedError();
  }

  @override
  Future<void> update(SingleItem item) => _isar(
        (isar) => isar.isarSingleItems.get(item.id).then(
          (isarItem) {
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
              isar.isarSingleItems.put(isarItem);
            }
          },
        ),
      );
}
