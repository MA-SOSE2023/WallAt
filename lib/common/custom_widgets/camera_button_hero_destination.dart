import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_nav_bar/bottom_nav_bar_model.dart';
import '/common/provider.dart';

const String cameraButtonHeroTag = 'cameraFloatingActionButtonHero';

class CameraButtonHeroDestination extends ConsumerWidget {
  const CameraButtonHeroDestination({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomBottomNavBarModel bottomNavBarModel =
        ref.read(Providers.customBottomNavBarControllerProvider);
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.only(right: bottomNavBarModel.iconPadding.right),
      child: Hero(
        tag: cameraButtonHeroTag,
        flightShuttleBuilder: (flightContext, animation, flightDirection,
                fromHeroContext, toHeroContext) =>
            Stack(
          children: [
            FadeTransition(opacity: animation, child: toHeroContext.widget),
            FadeTransition(
                opacity: ReverseAnimation(animation),
                child: fromHeroContext.widget),
          ],
        ),
        child: Icon(
          CupertinoIcons.camera,
          size: bottomNavBarModel.iconSize,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
