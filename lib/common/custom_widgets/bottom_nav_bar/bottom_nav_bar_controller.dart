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
      icon: Icon(CupertinoIcons.home),
      activeIcon: Icon(CupertinoIcons.house_fill),
      label: 'HOME',
      initialLocation: '/home',
    ),
    CustomBottomNavBarItem(
      icon: Icon(CupertinoIcons.heart),
      activeIcon: Icon(CupertinoIcons.heart_fill),
      label: 'FAVORITES',
      initialLocation: '/favorites',
    ),
    CustomBottomNavBarItem(
      icon: Icon(CupertinoIcons.folder),
      activeIcon: Icon(CupertinoIcons.folder_fill),
      label: 'FOLDERS',
      initialLocation: '/folders',
    ),
  ];

  static final CustomBottomNavBarItem _cameraItem = CustomBottomNavBarItem(
    icon: const Icon(CupertinoIcons.camera),
    activeIcon: const Icon(CupertinoIcons.camera_fill),
    label: 'CAMERA',
    initialLocation: '/camera',
    onTap: (ref) => ref
        .read(Providers.takePictureControllerProvider(null).notifier)
        .takePicture(ref),
  );

  static const CustomBottomNavBarItem _settingsItem = CustomBottomNavBarItem(
    icon: Icon(CupertinoIcons.gear),
    activeIcon: Icon(CupertinoIcons.gear_solid),
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
    if (getNavBarItems()[index].onTap != null) {
      getNavBarItems()[index].onTap!(ref);
    } else {
      context.beamToNamed(getNavBarItems()[index].initialLocation);
    }

    if (state != updatedState) {
      state = updatedState;
    }
  }
}
