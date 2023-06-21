import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/pages/single_item/model/item_event.dart';

import '/common/custom_widgets/camera_button_hero_destination.dart';
import '/router/router.dart';
import 'home_model.dart';

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

abstract class HomeController extends StateNotifier<HomeModel> {
  HomeController(HomeModel state) : super(state);

  List<ItemEvent> get events => state.events;
}
