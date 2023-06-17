import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';

class CameraLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/camera'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('camera'),
          title: 'Camera',
          type: BeamPageType.noTransition,
          child:
              Placeholder(), // TODO: Favorites Screen, aka Folder Detail Screen
        ),
      ];
}