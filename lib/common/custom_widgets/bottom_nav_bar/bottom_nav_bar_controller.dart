import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'bottom_nav_bar_view.dart';

class CustomBottomNavBarControllerImpl extends CustomBottomNavBarController {
  CustomBottomNavBarControllerImpl() : super();

  @override
  List<CustomBottomNavBarItem> getNavBarItems() => [
        ...CustomBottomNavBar.baseItems,
        state.currentIndex == 0
            ? CustomBottomNavBar.settingsItem
            : CustomBottomNavBar.cameraItem
      ];

  @override
  void goToOtherPage(int index, BuildContext context) {
    double iconSize = state.iconSize;

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthIconPadding =
        (mediaQueryData.size.width / state.itemCount - iconSize) / 2;
    double heightIconPadding = (mediaQueryData.size.height - iconSize) / 2;

    CustomBottomNavBarModel updatedState = state.copyWith(
      currentIndex: index,
      iconPadding: EdgeInsets.only(
        left: widthIconPadding,
        right: widthIconPadding,
        top: heightIconPadding,
        bottom: heightIconPadding,
      ),
    );

    context.beamToNamed(getNavBarItems()[index].initialLocation);

    if (state != updatedState) {
      state = updatedState;
    }
  }
}
