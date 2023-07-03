import 'package:flutter_riverpod/flutter_riverpod.dart';

// Single Item
import '/pages/single_item/model/item_event.dart';
import '/pages/single_item/single_item_view.dart';
import '/pages/single_item/single_item_controller.dart';
import '/pages/single_item/edit_single_item_controller.dart';
import '/pages/single_item/edit_single_item_view.dart';
import '/pages/single_item/model/single_item.dart';
// Home
import '/pages/home/home_view.dart';
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
import '/common/services/persistence/db_model.dart';
import '/common/services/persistence/persistence_service.dart';
// Settings
import '/pages/settings/settings_view.dart';
import '/pages/settings/settings_controller.dart';
import '/pages/settings/settings_model.dart';
// Camera
import '/pages/camera/camera_view.dart';
import '/pages/camera/camera_controller.dart';
import '/pages/camera/camera_model.dart';
// Theme
import 'theme/theme_controller.dart';
import 'theme/custom_theme_data.dart';
//Profiles
import '/pages/profiles/profiles_view.dart';
import '/pages/profiles/profiles_controller.dart';
import '/pages/profiles/profile_model.dart';

import 'custom_widgets/all_custom_widgets.dart';

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
  static final AutoDisposeFutureProvider<HomeModel> homeControllerProvider =
      FutureProvider.autoDispose<HomeModel>(
    (ref) async {
      final PersistenceService service = ref.watch(persistenceServiceProvider);
      final List<SingleItem> recentItems = await service.getRecentItems();
      final List<ItemEvent> soonEvents = await service.getSoonEvents();
      for (final SingleItem item in recentItems) {
        ref.listen(singleItemControllerProvider(item.id), (previous, next) {
          ref.invalidateSelf();
        });
      }
      return HomeModel(recentItems: recentItems, events: soonEvents);
    },
  );

  /// Provider for [FavoritesScreen]
  /// - Provides a [FavoritesController] for a List of [SingleItem]s
  static final StateNotifierProvider<FavoritesController,
          Future<List<SingleItem>>> favoritesControllerProvider =
      StateNotifierProvider<FavoritesController, Future<List<SingleItem>>>(
          (ref) =>
              FavoritesControllerImpl(ref.watch(persistenceServiceProvider)));

  static final StateNotifierProviderFamily<FoldersController, Folder, int>
      _foldersControllerProvider = StateNotifierProvider.family(
    (ref, folderId) => FoldersControllerImpl(
      folderId: folderId,
      persistence: ref.watch(persistenceServiceProvider),
      ref: ref,
    ),
  );

  static final StateNotifierProvider<FoldersController, Folder>
      _rootFolderProvider = _foldersControllerProvider(-1);

  /// Provider for [FoldersScreen]
  /// - Provides a [FoldersController] for a [Folder]
  // Proxies to either the root folder or a subfolder
  static StateNotifierProvider<FoldersController, Folder>
      foldersControllerProvider(int? arg) {
    if (arg == null) {
      return _rootFolderProvider;
    } else {
      return _foldersControllerProvider(arg);
    }
  }

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
    return IsarController();
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
