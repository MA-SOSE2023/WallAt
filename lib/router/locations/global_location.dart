import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:gruppe4/pages/profiles/profiles_view.dart';
import 'package:gruppe4/pages/settings/settings_view.dart';
import 'package:gruppe4/pages/camera/camera_model.dart';
import 'package:gruppe4/pages/camera/camera_view.dart';
import 'package:gruppe4/pages/single_item/move_to_folder_view.dart';

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
        routeInformation.location != '/camera' &&
        routeInformation.location != '/profiles' &&
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
          BeamPage(
            key: const ValueKey('splash'),
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
            child: const ProfilesPage(), // TODO: Profiles Screen
          ),
        if (state.routeInformation.location == '/camera/view')
          BeamPage(
              key: const ValueKey('camera_view'),
              title: 'Camera View',
              type: BeamPageType.cupertino,
              child: SaveItemScreen(item: data as Future<SingleItem?>)),
        if (state.routeInformation.location == '/item/move')
          BeamPage(
            key: const ValueKey('item_move'),
            title: 'Move Item',
            type: BeamPageType.cupertino,
            popToNamed: prevNavBarLocation,
            child: MoveToFolderScreen(item: data as SingleItem),
          ),
        if (state.routeInformation.location == '/item')
          BeamPage(
            key: const ValueKey('item'),
            title: 'Item',
            type: BeamPageType.cupertino,
            popToNamed: prevNavBarLocation,
            child: SingleItemPage(item: data as SingleItem),
          ),
      ];
}
