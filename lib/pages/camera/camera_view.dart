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
      final pictures = await controller.takePicture();
      if (pictures != null) {
        controller.setPictures(pictures);
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => DisplayPicturesScreen(model: model),
          ),
        );
      }
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

class DisplayPicturesScreen extends StatelessWidget {
  final TakePictureModel model;

  const DisplayPicturesScreen({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
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

  Future<List<String>?> takePicture();
  void setPictures(List<String> pictures);
}
