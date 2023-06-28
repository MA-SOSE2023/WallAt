import 'package:gruppe4/common/services/persistence/db_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'dao/isar_folder_dao.dart';
import 'dao/isar_item_event_dao.dart';
import 'dao/isar_single_item_dao.dart';
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

    SingleItemDao singleItemDao = IsarSingleItemDao(db: db);
    FolderDao folderDao = IsarFolderDao(db: db);
    ItemEventDao eventDao = IsarItemEventDao(db: db);

    state = state.copyWith(
        db: db,
        singleItemDao: singleItemDao,
        folderDao: folderDao,
        eventDao: eventDao,
        rootFolderId: (await folderDao.createOrFindRoot()));
  }

  Future<bool> closeDb() async {
    if (state.db == null) {
      return false;
    }
    (await state.db!).close();
    state = state.copyWith(
        db: null,
        singleItemDao: null,
        folderDao: null,
        eventDao: null,
        rootFolderId: null);
    return true;
  }

  @override
  Future<ItemEventDao> get eventDio async {
    if (state.db == null) {
      await openDb();
    }
    return state.eventDao!;
  }

  @override
  Future<FolderDao> get folderDio async {
    if (state.db == null) {
      await openDb();
    }
    return state.folderDao!;
  }

  @override
  Future<SingleItemDao> get singleItemDio async {
    if (state.db == null) {
      await openDb();
    }
    return state.singleItemDao!;
  }

  @override
  Future<int> get rootFolderId async {
    if (state.db == null) {
      await openDb();
    }
    return state.rootFolderId!;
  }
}
