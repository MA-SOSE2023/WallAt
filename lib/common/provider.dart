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

import 'custom_widgets/all_custom_widgets.dart';

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

  static final navigatorKeyProvider =
      Provider<GlobalKey<NavigatorState>>((ref) {
    return GlobalKey<NavigatorState>();
  });

  static final enabelHeroAnimationProvider = StateProvider<bool>((ref) {
    return true;
  });
}
