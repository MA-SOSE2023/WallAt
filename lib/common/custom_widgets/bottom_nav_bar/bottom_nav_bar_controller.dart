import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_nav_bar_view.dart';
import '/common/provider.dart';
import '/common/localization/language.dart';

class CustomBottomNavBarControllerImpl extends CustomBottomNavBarController {
  CustomBottomNavBarControllerImpl({required Language language})
      : _language = language,
        super();

  final Language _language;

  List<CustomBottomNavBarItem> get _baseItems => [
        CustomBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          activeIcon: const Icon(CupertinoIcons.house_fill),
          label: _language.lblHome,
          initialLocation: '/home',
        ),
        CustomBottomNavBarItem(
          icon: const Icon(CupertinoIcons.heart),
          activeIcon: const Icon(CupertinoIcons.heart_fill),
          label: _language.lblFavorites,
          initialLocation: '/favorites',
        ),
        CustomBottomNavBarItem(
          icon: const Icon(CupertinoIcons.folder),
          activeIcon: const Icon(CupertinoIcons.folder_fill),
          label: _language.lblFolders,
          initialLocation: '/folders',
        ),
      ];

  CustomBottomNavBarItem get _cameraItem => CustomBottomNavBarItem(
        icon: const Icon(CupertinoIcons.camera),
        activeIcon: const Icon(CupertinoIcons.camera_fill),
        label: _language.lblCamera,
        initialLocation: '/camera',
        onTap: (ref) => ref
            .read(Providers.takePictureControllerProvider(null).notifier)
            .takePicture(ref),
      );

  CustomBottomNavBarItem get _settingsItem => CustomBottomNavBarItem(
        icon: const Icon(CupertinoIcons.gear),
        activeIcon: const Icon(CupertinoIcons.gear_solid),
        label: _language.lblSettings,
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
