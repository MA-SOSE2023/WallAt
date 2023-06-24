import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:gruppe4/pages/camera/camera_model.dart';
import 'package:gruppe4/pages/camera/camera_view.dart';

import '/common/custom_widgets/bottom_nav_bar/bottom_nav_bar_view.dart';

class GlobalLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/home',
        '/favorites',
        '/folders',
        '/camera',
        '/camera/view',
        '/settings',
        '/profiles'
      ];

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
        if (state.routeInformation.location == '/profiles')
          const BeamPage(
            key: ValueKey('home'),
            title: 'Profiles',
            type: BeamPageType.cupertino,
            child: Placeholder(), // TODO: Profiles Screen
          ),
        if (state.routeInformation.location?.startsWith('/camera') ?? false)
          const BeamPage(
            key: ValueKey('camera'),
            title: 'Camera',
            type: BeamPageType.cupertino,
            child: Placeholder(), // TODO: Camera Screen
          ),
        if (state.routeInformation.location == '/camera/view')
          BeamPage(
            key: const ValueKey('camera_view'),
            title: 'Camera View',
            type: BeamPageType.cupertino,
            child: DisplayPicturesScreen(
                model: data as TakePictureModel), // TODO: Camera View Screen
          ),
      ];
}
