import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/common/custom_widgets/camera_button_hero_destination/camera_button_hero_destination_view.dart';
import '/router/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CupertinoNavigationBar(
          middle: Text('Home'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15.0, right: 10.0),
          child: FloatingActionButton(
            foregroundColor: CupertinoTheme.of(context).primaryContrastingColor,
            backgroundColor: CupertinoTheme.of(context).primaryColor,
            onPressed: () =>
                Routers.globalRouterDelegate.beamToNamed('/camera'),
            heroTag: cameraButtonHeroTag,
            child: const Icon(
              CupertinoIcons.camera,
              size: 30,
            ),
          ),
        ),
        body: const Placeholder());
  }
}
