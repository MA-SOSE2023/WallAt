import 'package:isar/isar.dart';

import '/pages/single_item/model/single_item.dart';
import '/common/services/persistence/persistence_service.dart';

class IsarSingleItemDio extends SingleItemDio {
  IsarSingleItemDio({required Future<Isar> db}) : _db = db;

  final Future<Isar> _db;

  @override
  Future<SingleItem> create(
      {required String title,
      required String imagePath,
      required String description,
      required bool isFavorite,
      required int parentFolderId}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Id id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<SingleItem> read(Id id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<List<SingleItem>> readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<List<SingleItem>> readAllFavorites() {
    // TODO: implement readAllFavorites
    throw UnimplementedError();
  }

  @override
  Future<List<SingleItem>> readAllFavoritesMatching(String query) {
    // TODO: implement readAllFavoritesMatching
    throw UnimplementedError();
  }

  @override
  Future<List<SingleItem>> readAllMatching(String query) {
    // TODO: implement readAllMatching
    throw UnimplementedError();
  }

  @override
  Future<List<SingleItem>> readAllRecent() {
    // TODO: implement readAllRecent
    throw UnimplementedError();
  }

  @override
  Future<void> update(SingleItem item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
