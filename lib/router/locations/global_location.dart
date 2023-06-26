import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:gruppe4/pages/camera/camera_model.dart';
import 'package:gruppe4/pages/camera/camera_view.dart';

import '/pages/single_item/single_item_view.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show CustomBottomNavBarScreen;

class GlobalLocation extends BeamLocation<BeamState> {
  // The previous location needs to be handled manually, because otherwise
  // beaming to the camera or settings will not persist the previous location.
  String? prevNavBarLocation = '/home';

  @override
  List<String> get pathPatterns => [
        '/home',
        '/favorites',
        '/folders',
        '/camera/view',
        '/settings',
        '/profiles',
        '/item/:id',
      ];

  @override
  void updateState(RouteInformation routeInformation) {
    if (routeInformation.location != '/settings' &&
        routeInformation.location != '/camera' &&
        routeInformation.location != '/profiles' &&
        !(routeInformation.location ?? '').startsWith('/item')) {
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
        if (state.routeInformation.location == '/settings')
          BeamPage(
            key: const ValueKey('settings'),
            title: 'Settings',
            type: BeamPageType.cupertino,
            popToNamed: prevNavBarLocation,
            child: const Placeholder(), // TODO: Settings Screen
          ),
        if (state.routeInformation.location == '/profiles')
          BeamPage(
            key: const ValueKey('home'),
            title: 'Profiles',
            type: BeamPageType.cupertino,
            popToNamed: prevNavBarLocation,
            child: const Placeholder(), // TODO: Profiles Screen
          ),
        if (state.routeInformation.location == '/camera/view')
          BeamPage(
              key: const ValueKey('camera_view'),
              title: 'Camera View',
              type: BeamPageType.cupertino,
              child: DisplayPicturesScreen(model: data as TakePictureModel)),
        if ((state.routeInformation.location ?? '').startsWith('/item'))
          BeamPage(
            key: const ValueKey('item'),
            title: 'Item',
            type: BeamPageType.cupertino,
            popToNamed: prevNavBarLocation,
            child: SingleItemPage(id: int.parse(state.pathParameters['id']!)),
          ),
      ];
}
