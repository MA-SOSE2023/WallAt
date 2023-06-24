import 'package:flutter/cupertino.dart';

import '/common/custom_widgets/all_custom_widgets.dart'
    show CameraButtonHeroDestination;

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
