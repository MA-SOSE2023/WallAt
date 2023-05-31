import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';

class FavoritesLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/favorites'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('favorites'),
          title: 'Favorites',
          type: BeamPageType.noTransition,
          child:
              Placeholder(), // TODO: Favorites Screen, aka Folder Detail Screen
        ),
      ];
}
