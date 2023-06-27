import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

// Settings
import '/pages/settings/settings_view.dart';
import '/pages/settings/settings_controller.dart';
import '/pages/settings/settings_model.dart';

import 'custom_widgets/all_custom_widgets.dart';

import 'custom_widgets/bottom_nav_bar/bottom_nav_bar_controller.dart';
// Camera
import '/pages/camera/camera_view.dart';
import '/pages/camera/camera_controller.dart';
import '/pages/camera/camera_model.dart';

// theme
import 'theme/theme_controller.dart';
import 'theme/custom_theme_data.dart';

/// Flutter Riverpod providers
class Providers {
  /// Provider for [SingleItemPage]
  /// - Provides a [SingleItemController] for a [SingleItem]
  static final AutoDisposeStateNotifierProviderFamily<SingleItemController,
          SingleItem, String> singleItemControllerProvider =
      StateNotifierProvider.autoDispose.family((ref, id) {
    return SingleItemControllerMock(id: id);
  });

  /// Provider for [EditSingleItemPage]
  /// - Provides a [EditSingleItemController] for a [SingleItem]
  static final AutoDisposeStateNotifierProviderFamily<EditSingleItemController,
          SingleItem, String> editSingleItemControllerProvider =
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
  static final AutoDisposeStateNotifierProviderFamily<FoldersController, Folder,
          String> foldersControllerProvider =
      StateNotifierProvider.autoDispose.family((ref, id) {
    return FoldersControllerMock(id);
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
  /// - Provides a [CalendarButtonController] for a [CalendarModel]
  static final StateNotifierProvider<CalendarButtonController, CalendarModel>
      calendarButtonControllerProvider =
      StateNotifierProvider<CalendarButtonController, CalendarModel>((ref) {
    return CalendarButtonControllerImpl();
  });

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
    final settingsController = ref.watch(settingsControllerProvider);
    final index = settingsController.selectedThemeIndex;
    print(index);
    return ThemeControllerImpl(index: index);
  });
}
