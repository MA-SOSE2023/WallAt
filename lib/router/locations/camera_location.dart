import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';

import '/pages/camera/camera_view.dart';

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
              TakePictureScreen(),
        ),
      ];
}