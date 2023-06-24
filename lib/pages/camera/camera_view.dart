import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/provider.dart';
import 'dart:io';

import 'camera_controller.dart';
import 'camera_model.dart';

class TakePictureScreen extends ConsumerWidget {
  const TakePictureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TakePictureModel model =
        ref.watch(Providers.takePictureControllerProvider);
    final TakePictureController controller =
        ref.read(Providers.takePictureControllerProvider.notifier);

    Future<void> initPlatformState() async {
      controller.takePicture();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPlatformState();
    });

    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Take a picture'),
      ),
      child: CupertinoActivityIndicator(),
    );
  }
}

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
          }),
          middle: Text('Captured Pictures'),
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
