import 'package:flutter_riverpod/flutter_riverpod.dart';

// Single Item
import '../pages/single_item/single_item_view.dart';
import '../pages/single_item/single_item_controller.dart';
import '../pages/single_item/model/single_item.dart';

/// Flutter Riverpod providers
class Providers {
  /// Provider for [SingleItemPage]
  /// - Provides a [SingleItemController] for a [SingleItem]
  static final AutoDisposeStateNotifierProviderFamily<SingleItemController,
          SingleItem, String> singleItemControllerProvider =
      StateNotifierProvider.autoDispose.family((ref, id) {
    return SingleItemControllerMock(id: id);
  });
}
