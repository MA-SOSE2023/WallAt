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
  IsarController() : super(DbModel()) {
    openDb();
  }

  @override
  Future<void> openDb() async {
    if (state.db != null) {
      return;
    }
    late Isar db;
    if (Isar.instanceNames.isEmpty) {
      db = await Isar.open(
        [IsarSingleItemSchema, IsarFolderSchema, IsarItemEventSchema],
        directory: (await getApplicationDocumentsDirectory()).path,
        inspector: true, // Inspector allows real-time insight into the database
        // we might want to disable this in production
      );
    } else {
      db = Isar.getInstance()!;
    }

    SingleItemDao singleItemDao = IsarSingleItemDao(db: db);
    FolderDao folderDao = IsarFolderDao(db: db);
    ItemEventDao eventDao = IsarItemEventDao(db: db);

    state = state.copyWith(
        db: Future.delayed(const Duration(milliseconds: 500), () => db),
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
        singleItemDao: null,
        folderDao: null,
        eventDao: null,
        rootFolderId: null);
    return true;
  }

  @override
  Future<ItemEventDao> get eventDao async {
    if (state.eventDao == null) {
      await openDb();
    }
    return state.eventDao!;
  }

  @override
  Future<FolderDao> get folderDao async {
    if (state.folderDao == null) {
      await openDb();
    }
    return state.folderDao!;
  }

  @override
  Future<SingleItemDao> get singleItemDao async {
    if (state.singleItemDao == null) {
      await openDb();
    }
    return state.singleItemDao!;
  }

  @override
  Future<int> get rootFolderId async {
    if (state.rootFolderId == null) {
      await openDb();
    }
    return state.rootFolderId!;
  }
}
