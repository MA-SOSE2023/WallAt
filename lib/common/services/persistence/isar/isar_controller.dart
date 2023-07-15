import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'dao/isar_folder_dao.dart';
import 'dao/isar_item_event_dao.dart';
import 'dao/isar_single_item_dao.dart';
import 'dao/isar_profile_dao.dart';
import 'schemas/isar_folder.dart';
import 'schemas/isar_item_event.dart';
import 'schemas/isar_profile.dart';
import 'schemas/isar_single_item.dart';
import '../db_model.dart';
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
      try {
        db = Isar.openSync(
          [
            IsarSingleItemSchema,
            IsarFolderSchema,
            IsarItemEventSchema,
            IsarProfileSchema
          ],
          directory: (await getApplicationDocumentsDirectory()).path,
          inspector:
              true, // Inspector allows real-time insight into the database
          // we might want to disable this in production
        );
      } catch (e) {
        // Bug in Isar causes instanceNames to be updated late
        // so openDb often lands here even though the db is already open
        db = Isar.getInstance()!;
      }
    } else {
      db = Isar.getInstance()!;
    }

    SingleItemDao singleItemDao = IsarSingleItemDao(db: db);
    FolderDao folderDao = IsarFolderDao(db: db);
    ItemEventDao eventDao = IsarItemEventDao(db: db);
    ProfileDao profileDao = IsarProfileDao(db: db);

    state = state.copyWith(
      db: Future.delayed(const Duration(milliseconds: 500), () => db),
      singleItemDao: singleItemDao,
      folderDao: folderDao,
      eventDao: eventDao,
      profileDao: profileDao,
    );
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
      profileDao: null,
    );
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
  Future<ProfileDao> get profileDao async {
    if (state.profileDao == null) {
      await openDb();
    }
    return state.profileDao!;
  }

  @override
  Future<int> rootFolderId(int profileId) async {
    if (state.folderDao == null) {
      await openDb();
    }
    return await state.folderDao!.createOrFindRoot(profileId);
  }

  @override
  Future<int> get defaultProfileId async {
    if (state.profileDao == null) {
      await openDb();
    }
    return await state.profileDao!.createOrFindDefault();
  }

  @override
  Future<void> clearDb() async {
    if (state.db == null) {
      await openDb();
    }
    final Isar db = await state.db!;
    return db.writeTxnSync(() => db.clearSync());
  }
}
