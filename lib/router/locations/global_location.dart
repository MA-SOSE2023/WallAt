import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';

import '/common/custom_widgets/bottom_nav_bar/bottom_nav_bar_view.dart';
import '/pages/camera/camera_view.dart';

class GlobalLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns =>
      ['/home', '/favorites', '/folders', '/camera', '/settings', '/profiles'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('global'),
          type: BeamPageType.noTransition,
          child: CustomBottomNavBarScreen(),
        ),
        if (state.routeInformation.location == '/settings')
          const BeamPage(
            key: ValueKey('settings'),
            title: 'Settings',
            type: BeamPageType.cupertino,
            child: Placeholder(), // TODO: Settings Screen
          ),
        if (state.routeInformation.location == '/camera')
          const BeamPage(
            key: ValueKey('camera'),
            title: 'Camera',
            type: BeamPageType.cupertino,
            child: Placeholder(), // TODO: Camera Screen
          ),
        if (state.routeInformation.location == '/profiles')
          const BeamPage(
            key: ValueKey('home'),
            title: 'Profiles',
            type: BeamPageType.cupertino,
            child: Placeholder(), // TODO: Profiles Screen
          ),
      ];
}
