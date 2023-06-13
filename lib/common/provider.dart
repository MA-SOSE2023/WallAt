import 'package:flutter_riverpod/flutter_riverpod.dart';

// Single Item
import '../pages/single_item/single_item_view.dart';
import '../pages/single_item/single_item_controller.dart';
import '../pages/single_item/model/single_item.dart';
import 'custom_widgets/all_custom_widgets.dart';

import 'custom_widgets/bottom_nav_bar/bottom_nav_bar_controller.dart';

/// Flutter Riverpod providers
class Providers {
  /// Provider for [SingleItemPage]
  /// - Provides a [SingleItemController] for a [SingleItem]
  static final AutoDisposeStateNotifierProviderFamily<SingleItemController,
          SingleItem, String> singleItemControllerProvider =
      StateNotifierProvider.autoDispose.family((ref, id) {
    return SingleItemControllerMock(id: id);
  });

  /// Provider for [CustomBottomNavBar]
  /// - Provides a [CustomBottomNavBarController] for a [CustomBottomNavBarModel]
  static final StateNotifierProvider<CustomBottomNavBarController,
          CustomBottomNavBarModel> customBottomNavBarControllerProvider =
      StateNotifierProvider<CustomBottomNavBarController,
          CustomBottomNavBarModel>((ref) => CustomBottomNavBarControllerImpl());
}
