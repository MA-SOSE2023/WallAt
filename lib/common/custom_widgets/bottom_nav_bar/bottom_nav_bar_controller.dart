import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'bottom_nav_bar_view.dart';
import 'bottom_nav_bar_model.dart';

class CustomBottomNavBarControllerImpl extends CustomBottomNavBarController {
  CustomBottomNavBarControllerImpl() : super();

  @override
  set currentIndex(int index) {
    // TODO: implement currentIndex
  }

  @override
  List<BottomNavigationBarItem> getNavBarItems() {
    // TODO: implement getNavBarItems
    throw UnimplementedError();
  }

  @override
  void goToOtherPage(int index, BuildContext context) {
    // TODO: implement goToOtherPage
  }

  @override
  set iconSize(double iconSize) {
    // TODO: implement iconSize
  }
}
