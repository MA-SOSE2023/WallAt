import 'package:flutter/cupertino.dart';

import '/common/custom_widgets/camera_button_hero_destination/camera_button_hero_destination_view.dart';

class FavoritesScren extends StatelessWidget {
  const FavoritesScren({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Favorites'),
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
