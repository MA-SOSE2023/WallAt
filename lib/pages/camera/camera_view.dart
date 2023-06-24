import 'dart:io';

import 'package:flutter/cupertino.dart';
import '/pages/camera/camera_controller.dart';
import '/pages/camera/camera_model.dart';

class TakePictureScreen extends StatelessWidget {
  
  const TakePictureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TakePictureController();
    final model = TakePictureModel();

    Future<void> initPlatformState() async {
      final pictures = await controller.takePicture();
      if (pictures != null) {
        model.setPictures(pictures);
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => DisplayPicturesScreen(model: model),
          ),
        );
      }
    }

    WidgetsBinding.instance!.addPostFrameCallback((_) {
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

  const DisplayPicturesScreen({Key? key, required this.model}) : super(key: key);

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
      )
    );
  }
}
