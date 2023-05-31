import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_widgets/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'custom_widgets/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'custom_widgets/bottom_nav_bar/bottom_nav_bar_model.dart';

/// Flutter Riverpod providers
class Providers {
  /// Provider for [CustomBottomNavBar]
  /// - Provides a [CustomBottomNavBarController] for a [CustomBottomNavBarModel]
  static final StateNotifierProvider<CustomBottomNavBarController,
          CustomBottomNavBarModel> customBottomNavBarControllerProvider =
      StateNotifierProvider<CustomBottomNavBarController,
          CustomBottomNavBarModel>((ref) => CustomBottomNavBarControllerImpl());
}
