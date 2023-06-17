import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';


class TakePictureScreen extends StatefulWidget {
  
  const TakePictureScreen({Key? key}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription _camera;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _camera = cameras.first;
    _controller = CameraController(
      _camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const CupertinoPageScaffold(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Take a picture'),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CupertinoActivityIndicator());
                }
              },
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: SafeArea(
              child: CupertinoButton(
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;

                    final image = await _controller.takePicture();

                    if (!mounted) return;

                    await Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => DisplayPictureScreen(
                          imagePath: image.path,
                        ),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                color: CupertinoColors.activeBlue,
                borderRadius: BorderRadius.circular(25),
                padding: const EdgeInsets.all(12),
                child: const Icon(CupertinoIcons.camera, color: CupertinoColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);
      
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Display the Picture'),
      ),
      child: SafeArea(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}