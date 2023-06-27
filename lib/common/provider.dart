import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/services/persistence/db_model.dart';
import 'package:gruppe4/common/services/persistence/persistence_service.dart';
import 'package:isar/isar.dart';

// Single Item
import '/pages/single_item/single_item_view.dart';
import '/pages/single_item/single_item_controller.dart';
import '/pages/single_item/edit_single_item_controller.dart';
import '/pages/single_item/edit_single_item_view.dart';
import '/pages/single_item/model/single_item.dart';
// Home
import '/pages/home/home_view.dart';
import '/pages/home/home_controller.dart';
import '/pages/home/home_model.dart';
// Favorites
import '/pages/favorites/favorites_view.dart';
import '/pages/favorites/favorites_controller.dart';
// Folders
import '/pages/folders/folders_view.dart';
import '/pages/folders/folders_controller.dart';
import '/pages/folders/folder_model.dart';
// Persistence
import '/common/services/persistence/isar/isar_controller.dart';

// CalendarButton

import 'custom_widgets/all_custom_widgets.dart';

// Camera
import '/pages/camera/camera_view.dart';
import '/pages/camera/camera_controller.dart';
import '/pages/camera/camera_model.dart';

/// Flutter Riverpod providers
class Providers {
  /// Provider for [SingleItemPage]
  /// - Provides a [SingleItemController] for a [SingleItem]
  static final AutoDisposeStateNotifierProviderFamily<SingleItemController,
          SingleItem, int> singleItemControllerProvider =
      StateNotifierProvider.autoDispose.family((ref, id) {
    return SingleItemControllerMock(id: id);
  });

  /// Provider for [EditSingleItemPage]
  /// - Provides a [EditSingleItemController] for a [SingleItem]
  static final AutoDisposeStateNotifierProviderFamily<EditSingleItemController,
          SingleItem, int> editSingleItemControllerProvider =
      StateNotifierProvider.autoDispose.family((ref, id) {
    return EditSingleItemControllerMock(
        id: id, model: ref.read(singleItemControllerProvider(id)));
  });

  /// Provider for [HomeScreen]
  /// - Provides a [HomeController] for a [HomeModel]
  static final StateNotifierProvider<HomeController, HomeModel>
      homeControllerProvider =
      StateNotifierProvider<HomeController, HomeModel>((ref) {
    return HomeControllerMock();
  });

  /// Provider for [FavoritesScreen]
  /// - Provides a [FavoritesController] for a List of [SingleItem]s
  static final FutureProvider<List<SingleItem>> favoritesControllerProvider =
      FutureProvider<List<SingleItem>>((ref) async {
    return Future.delayed(
        const Duration(seconds: 1), () => FavoritesControllerMock().favorites);
  });

  /// Provider for [FoldersScreen]
  /// - Provides a [FoldersController] for a [Folder]
  static final AutoDisposeStateNotifierProviderFamily<FoldersController,
          Future<Folder?>, int> foldersControllerProvider =
      StateNotifierProvider.autoDispose.family((ref, id) {
    return FoldersControllerImpl(id, ref.read(persistenceServiceProvider));
  });

  /// Provider for [CustomBottomNavBar]
  /// - Provides a [CustomBottomNavBarController] for a [CustomBottomNavBarModel]
  static final StateNotifierProvider<CustomBottomNavBarController,
          CustomBottomNavBarModel> customBottomNavBarControllerProvider =
      StateNotifierProvider<CustomBottomNavBarController,
          CustomBottomNavBarModel>((ref) => CustomBottomNavBarControllerImpl());

  /// Provider for [TakePictureController]
  /// - Provides a [TakePictureController] for a [TakePictureModel]
  static final StateNotifierProvider<TakePictureController, TakePictureModel>
      takePictureControllerProvider =
      StateNotifierProvider<TakePictureController, TakePictureModel>(
          (ref) => TakePictureControllerImpl());
  static final navigatorKeyProvider =
      Provider<GlobalKey<NavigatorState>>((ref) {
    return GlobalKey<NavigatorState>();
  });

  static final enableHeroAnimationProvider = StateProvider<bool>((ref) {
    return true;
  });

  /// Provider for [CalendarButton]
  /// - Provides a [CalendarButtonController] for a [CalendarButton]
  static final StateNotifierProvider<CalendarButtonController, CalendarModel>
      calendarButtonControllerProvider =
      StateNotifierProvider<CalendarButtonController, CalendarModel>((ref) {
    return CalendarButtonControllerImpl();
  });

  static final StateNotifierProvider<DbController, DbModel>
      dbControllerProvider =
      StateNotifierProvider<DbController, DbModel>((ref) {
    DbController dbController = IsarController();
    dbController.openDb();
    return dbController;
  });

  static final Provider<PersistenceService> persistenceServiceProvider =
      Provider<PersistenceService>((ref) {
    final DbController dbController = ref.read(dbControllerProvider.notifier);
    return PersistenceService(controller: dbController);
  });
}
