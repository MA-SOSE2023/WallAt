import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';

import '/pages/favorites/favorites_view.dart';

class FavoritesLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/favorites'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('favorites'),
          title: 'Favorites',
          type: BeamPageType.noTransition,
          child: FavoritesScreen(),
        ),
      ];
}
