import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';

import '/pages/profiles/profiles_view.dart';
import '/pages/settings/settings_view.dart';
import '/pages/camera/camera_view.dart';
import '/pages/single_item/move_to_folder_view.dart';
import '/pages/single_item/model/single_item.dart';
import '/pages/single_item/single_item_view.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show CustomBottomNavBarScreen;

import '/splash_screen.dart';

class GlobalLocation extends BeamLocation<BeamState> {
  // The previous location needs to be handled manually, because otherwise
  // beaming to the camera or settings will not persist the previous location.
  String? prevNavBarLocation = '/home';

  @override
  List<String> get pathPatterns => [
        '/home',
        '/splash',
        '/favorites',
        '/folders',
        '/camera/view',
        '/settings',
        '/profiles',
        '/item',
        '/item/move',
      ];

  @override
  void updateState(RouteInformation routeInformation) {
    if (routeInformation.location != '/settings' &&
        routeInformation.location != '/profiles' &&
        !(routeInformation.location?.startsWith('/camera') ?? false) &&
        !(routeInformation.location?.startsWith('/item') ?? false)) {
      prevNavBarLocation = routeInformation.location;
    }
    super.updateState(routeInformation);
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('global'),
          type: BeamPageType.noTransition,
          child: CustomBottomNavBarScreen(),
        ),
        if (state.routeInformation.location == '/splash')
          const BeamPage(
            key: ValueKey('splash'),
            title: 'Splash',
            type: BeamPageType.cupertino,
            child: SplashScreen(),
          ),
        if (state.routeInformation.location == '/settings')
          BeamPage(
            key: const ValueKey('settings'),
            title: 'Settings',
            type: BeamPageType.cupertino,
            popToNamed: prevNavBarLocation,
            child: const SettingsPage(),
          ),
        if (state.routeInformation.location == '/profiles')
          BeamPage(
            key: const ValueKey('home'),
            title: 'Profiles',
            type: BeamPageType.cupertino,
            popToNamed: prevNavBarLocation,
            child: const ProfilesPage(),
          ),
        if (state.routeInformation.location == '/camera/view')
          BeamPage(
              key: const ValueKey('camera_view'),
              title: 'Camera View',
              type: BeamPageType.cupertino,
              popToNamed: prevNavBarLocation,
              child: SaveItemScreen(item: data as Future<SingleItem?>)),
        if (state.routeInformation.location?.startsWith('/item') ?? false) ...[
          BeamPage(
            key: const ValueKey('item'),
            title: 'Item',
            type: BeamPageType.cupertino,
            popToNamed: prevNavBarLocation,
            child: SingleItemPage(item: data as SingleItem),
          ),
          if (state.routeInformation.location == '/item/move')
            BeamPage(
              key: const ValueKey('item_move'),
              title: 'Move Item',
              type: BeamPageType.cupertino,
              popToNamed: prevNavBarLocation,
              child: MoveToFolderScreen(item: data as SingleItem, folder: null),
            ),
        ]
      ];
}
