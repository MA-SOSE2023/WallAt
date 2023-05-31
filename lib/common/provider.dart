import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_widgets/all_custom_widgets.dart';

import 'custom_widgets/bottom_nav_bar/bottom_nav_bar_controller.dart';

/// Flutter Riverpod providers
class Providers {
  /// Provider for [CustomBottomNavBar]
  /// - Provides a [CustomBottomNavBarController] for a [CustomBottomNavBarModel]
  static final StateNotifierProvider<CustomBottomNavBarController,
          CustomBottomNavBarModel> customBottomNavBarControllerProvider =
      StateNotifierProvider<CustomBottomNavBarController,
          CustomBottomNavBarModel>((ref) => CustomBottomNavBarControllerImpl());
}
