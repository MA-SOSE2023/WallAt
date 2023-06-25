import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_nav_bar_view.dart';
import '/common/provider.dart';

class CustomBottomNavBarControllerImpl extends CustomBottomNavBarController {
  CustomBottomNavBarControllerImpl() : super();

  static const List<CustomBottomNavBarItem> _baseItems = [
    CustomBottomNavBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'HOME',
      initialLocation: '/home',
    ),
    CustomBottomNavBarItem(
      icon: Icon(CupertinoIcons.heart),
      activeIcon: Icon(Icons.favorite),
      label: 'FAVORITES',
      initialLocation: '/favorites',
    ),
    CustomBottomNavBarItem(
      icon: Icon(Icons.folder_open),
      activeIcon: Icon(Icons.folder),
      label: 'FOLDERS',
      initialLocation: '/folders',
    ),
  ];

  static const CustomBottomNavBarItem _cameraItem = CustomBottomNavBarItem(
    icon: Icon(Icons.camera_alt_outlined),
    activeIcon: Icon(Icons.camera_alt),
    label: 'CAMERA',
    initialLocation: '/camera',
  );

  static const CustomBottomNavBarItem _settingsItem = CustomBottomNavBarItem(
    icon: Icon(Icons.settings_outlined),
    activeIcon: Icon(Icons.settings),
    label: 'SETTINGS',
    initialLocation: '/settings',
  );

  @override
  List<CustomBottomNavBarItem> getNavBarItems() =>
      [..._baseItems, state.currentIndex == 0 ? _settingsItem : _cameraItem];

  @override
  void goToOtherPage(int index, BuildContext context, WidgetRef ref) {
    double iconSize = state.iconSize;

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthIconPadding =
        (mediaQueryData.size.width / state.itemCount - iconSize) / 2;
    double heightIconPadding = (mediaQueryData.size.height - iconSize) / 2;

    CustomBottomNavBarModel updatedState = state.copyWith(
      currentIndex: index == 3 ? state.currentIndex : index,
      iconPadding: EdgeInsets.only(
        left: widthIconPadding,
        right: widthIconPadding,
        top: heightIconPadding,
        bottom: heightIconPadding,
      ),
    );

    ref.read(Providers.enableHeroAnimationProvider.notifier).state = false;
    context.beamToNamed(getNavBarItems()[index].initialLocation);

    if (state != updatedState) {
      state = updatedState;
    }
  }
}
