import 'package:flutter/cupertino.dart';

import '/common/custom_widgets/camera_button_hero_destination.dart';

class FoldersScren extends StatelessWidget {
  const FoldersScren({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Folders'),
      ),
      child: Stack(
        children: const [
          SafeArea(
            child: Placeholder(),
          ),
          CameraButtonHeroDestination(),
        ],
      ),
    );
  }
}
