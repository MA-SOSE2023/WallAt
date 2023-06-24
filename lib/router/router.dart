import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';

import 'locations/locations.dart';

class Routers {
  /// Handles the highest level navigation.
  /// This is meant to contain the [bottomNavRouterDelegate] which handles the
  /// individual pages
  static final globalRouterDelegate = BeamerDelegate(
    initialPath: '/home',
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        GlobalLocation(),
      ],
    ),
  );

  /// Beamerkey for the bottom navigation router used for the individual pages
  static final bottomNavRouterBeamerKey = GlobalKey<BeamerState>();

  /// Handles the individual pages nested into the global navigation
  static final bottomNavRouterDelegate = BeamerDelegate(
    navigatorObservers: [HeroController()],
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        HomeLocation(),
        FavoritesLocation(),
        FoldersLocation(),
      ],
    ),
  );
}
