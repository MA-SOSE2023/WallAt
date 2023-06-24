import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_widgets/all_custom_widgets.dart';

import 'custom_widgets/bottom_nav_bar/bottom_nav_bar_controller.dart';
// Camera
import '/pages/camera/camera_view.dart';
import '/pages/camera/camera_controller.dart';
import '/pages/camera/camera_model.dart';

/// Flutter Riverpod providers
class Providers {
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
}
