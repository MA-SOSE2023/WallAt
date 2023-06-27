import 'package:gruppe4/common/services/persistence/db_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'dio/isar_folder_dio.dart';
import 'dio/isar_item_event_dio.dart';
import 'dio/isar_single_item_dio.dart';
import 'schemas/isar_folder.dart';
import 'schemas/isar_item_event.dart';
import 'schemas/isar_single_item.dart';
import '../persistence_service.dart';

class IsarController extends DbController {
  IsarController() : super(DbModel());

  @override
  Future<void> openDb() async {
    late Future<Isar> db;
    if (Isar.instanceNames.isEmpty) {
      db = Isar.open(
        [IsarSingleItemSchema, IsarFolderSchema, IsarItemEventSchema],
        directory: (await getApplicationDocumentsDirectory()).path,
        inspector: true, // Inspector allows real-time insight into the database
        // we might want to disable this in production
      );
    } else {
      db = Future.value(Isar.getInstance());
    }

    SingleItemDio singleItemDio = IsarSingleItemDio(db: db);
    FolderDio folderDio = IsarFolderDio(db: db);
    ItemEventDio eventDio = IsarItemEventDio(db: db);

    Id rootFolderId = (await folderDio.createOrFindRoot());

    state = state.copyWith(
        db: db,
        singleItemDio: singleItemDio,
        folderDio: folderDio,
        eventDio: eventDio,
        rootFolderId: rootFolderId);
  }

  Future<bool> closeDb() async {
    if (state.db == null) {
      return false;
    }
    (await state.db!).close();
    state = state.copyWith(
        db: null,
        singleItemDio: null,
        folderDio: null,
        eventDio: null,
        rootFolderId: null);
    return true;
  }

  @override
  Future<ItemEventDio> get eventDio async {
    if (state.db == null) {
      await openDb();
    }
    return state.eventDio!;
  }

  @override
  Future<FolderDio> get folderDio async {
    if (state.db == null) {
      await openDb();
    }
    return state.folderDio!;
  }

  @override
  Future<SingleItemDio> get singleItemDio async {
    if (state.db == null) {
      await openDb();
    }
    return state.singleItemDio!;
  }

  @override
  Future<int> get rootFolderId async {
    if (state.db == null) {
      await openDb();
    }
    return state.rootFolderId!;
  }
}
