import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/services/persistence/db_model.dart';
import 'package:gruppe4/common/services/persistence/persistence_service.dart';

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

// Settings
import '/pages/settings/settings_view.dart';
import '/pages/settings/settings_controller.dart';
import '/pages/settings/settings_model.dart';

import 'custom_widgets/all_custom_widgets.dart';

// Camera
import '/pages/camera/camera_view.dart';
import '/pages/camera/camera_controller.dart';
import '/pages/camera/camera_model.dart';

// theme
import 'theme/theme_controller.dart';
import 'theme/custom_theme_data.dart';

//Profiles
import '/pages/profiles/profiles_view.dart';
import '/pages/profiles/profiles_controller.dart';
import '/pages/profiles/profile_model.dart';

/// Flutter Riverpod providers
class Providers {
  /// Provider for [SingleItemPage]
  /// - Provides a [SingleItemController] for a [SingleItem]
  static final AutoDisposeAsyncNotifierProviderFamily<SingleItemController,
          SingleItem?, int> singleItemControllerProvider =
      AsyncNotifierProvider.autoDispose.family(SingleItemControllerImpl.new);

  /// Provider for [EditSingleItemPage]
  /// - Provides a [EditSingleItemController] for a [SingleItem]
  static final AutoDisposeStateNotifierProviderFamily<EditSingleItemController,
          SingleItem, SingleItem> editSingleItemControllerProvider =
      StateNotifierProvider.autoDispose.family(
    (ref, item) => EditSingleItemControllerImpl(item,
        controller: ref.read(singleItemControllerProvider(item.id).notifier)),
  );

  /// Provider for [HomeScreen]
  /// - Provides a [HomeController] for a [HomeModel]
  static final StateNotifierProvider<HomeController, Future<HomeModel>>
      homeControllerProvider =
      StateNotifierProvider<HomeController, Future<HomeModel>>(
          (ref) => HomeControllerImpl(ref.read(persistenceServiceProvider)));

  /// Provider for [FavoritesScreen]
  /// - Provides a [FavoritesController] for a List of [SingleItem]s
  static final StateNotifierProvider<FavoritesController,
          Future<List<SingleItem>>> favoritesControllerProvider =
      StateNotifierProvider<FavoritesController, Future<List<SingleItem>>>(
          (ref) =>
              FavoritesControllerImpl(ref.watch(persistenceServiceProvider)));

  /// Provider for [FoldersScreen]
  /// - Provides a [FoldersController] for a [Folder]
  static final AutoDisposeAsyncNotifierProviderFamily<FoldersController,
          Folder?, int?> foldersControllerProvider =
      AsyncNotifierProvider.autoDispose.family(FoldersControllerImpl.new);

  /// Provider for [CustomBottomNavBar]
  /// - Provides a [CustomBottomNavBarController] for a [CustomBottomNavBarModel]
  static final StateNotifierProvider<CustomBottomNavBarController,
          CustomBottomNavBarModel> customBottomNavBarControllerProvider =
      StateNotifierProvider<CustomBottomNavBarController,
          CustomBottomNavBarModel>((ref) => CustomBottomNavBarControllerImpl());

  /// Provider for [TakePictureController]
  /// - Provides a [TakePictureController] for a [TakePictureModel]
  static final AutoDisposeStateNotifierProviderFamily<TakePictureController,
          TakePictureModel, TakePictureModel?> takePictureControllerProvider =
      StateNotifierProvider.autoDispose.family((ref, state) =>
          TakePictureControllerImpl(
              state, ref.read(persistenceServiceProvider)));

  /// Provider for [CalendarButton]
  /// - Provides a [CalendarButtonController] for a [CalendarModel]
  static final StateNotifierProvider<CalendarButtonController, CalendarModel>
      calendarButtonControllerProvider =
      StateNotifierProvider<CalendarButtonController, CalendarModel>(
          (ref) => CalendarButtonControllerImpl());

  static final StateNotifierProvider<DbController, DbModel>
      dbControllerProvider =
      StateNotifierProvider<DbController, DbModel>((ref) {
    DbController dbController = IsarController();
    dbController.openDb();
    return dbController;
  });

  static final enableHeroAnimationProvider = StateProvider<bool>((ref) => true);

  static final Provider<PersistenceService> persistenceServiceProvider =
      Provider<PersistenceService>(
    (ref) =>
        PersistenceService(controller: ref.read(dbControllerProvider.notifier)),
  );

  /// Provider for [SettingsScreen]
  /// - Provides a [SettingsController] for a [SettingsModel]
  static final StateNotifierProvider<SettingsController, SettingsModel>
      settingsControllerProvider =
      StateNotifierProvider<SettingsController, SettingsModel>((ref) {
    return SettingsControllerImpl();
  });

  /// Provider for [ThemeModel]
  /// - Provides a [ThemeController] for a [ThemeModel]
  static final StateNotifierProvider<ThemeController, CustomThemeData>
      themeControllerProvider =
      StateNotifierProvider<ThemeController, CustomThemeData>((ref) {
    return ThemeControllerImpl(
        index: ref.watch(settingsControllerProvider).selectedThemeIndex);
  });

  /// Provider for [SettingsScreen]
  /// - Provides a [SettingsController] for a [SettingsModel]
  static final StateNotifierProvider<ProfilesController, List<ProfileModel>>
      profilesControllerProvider =
      StateNotifierProvider<ProfilesController, List<ProfileModel>>((ref) {
    return ProfilesControllerImpl();
  });
}
