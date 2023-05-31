import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'bottom_nav_bar_view.dart';

part 'bottom_nav_bar_model.freezed.dart';

@freezed
class CustomBottomNavBarModel with _$CustomBottomNavBarModel {
  const factory CustomBottomNavBarModel({
    @Default(0) int currentIndex,
    @Default(4) int itemCount,
    @Default(CustomBottomNavBar.iconSize) double iconSize,
    @Default(EdgeInsets.zero) EdgeInsets iconPadding,
  }) = _CustomBottomNavBarModel;
}
