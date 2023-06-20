import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';

import '/common/custom_widgets/bottom_nav_bar/bottom_nav_bar_view.dart';

class GlobalLocation extends BeamLocation<BeamState> {
  // The previous location needs to be handled manually, because otherwise
  // beaming to the camera or settings will not persist the previous location.
  String? prevNavBarLocation;

  @override
  List<String> get pathPatterns =>
      ['/home', '/favorites', '/folders', '/camera', '/settings', '/profiles'];

  @override
  void updateState(RouteInformation routeInformation) {
    if (routeInformation.location != '/settings' &&
        routeInformation.location != '/camera' &&
        routeInformation.location != '/profiles') {
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
            child: Placeholder(), // TODO: Settings Screen
          ),
        if (state.routeInformation.location == '/camera')
          BeamPage(
            key: const ValueKey('camera'),
            title: 'Camera',
            type: BeamPageType.cupertino,
            popToNamed: prevNavBarLocation,
            child: Placeholder(), // TODO: Camera Screen
          ),
        if (state.routeInformation.location == '/profiles')
          BeamPage(
            key: const ValueKey('home'),
            title: 'Profiles',
            type: BeamPageType.cupertino,
            popToNamed: prevNavBarLocation,
            child: Placeholder(), // TODO: Profiles Screen
          ),
      ];
}
