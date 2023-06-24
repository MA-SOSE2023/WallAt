import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'camera_model.dart';
import '/common/provider.dart';
import '/router/router.dart';

class DisplayPicturesScreen extends ConsumerWidget {
  final TakePictureModel model;

  const DisplayPicturesScreen({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoNavigationBarBackButton(onPressed: () {
            ref
                .read(Providers.takePictureControllerProvider.notifier)
                .setPictures([]);
            Routers.globalRouterDelegate.beamBack();
          }),
          middle: const Text('Captured Pictures'),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var picture in model.pictures)
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Image.file(File(picture)),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}

abstract class TakePictureController extends StateNotifier<TakePictureModel> {
  TakePictureController(TakePictureModel state) : super(state);

  void takePicture();
  void setPictures(List<String> pictures);
}
