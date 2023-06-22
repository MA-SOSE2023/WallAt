import 'dart:async';
import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/cupertino.dart';


class TakePictureScreen extends StatefulWidget {
  
  const TakePictureScreen({Key? key}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  List<String> _pictures = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      takePicture();
    });
  }

  void takePicture() async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      setState(() {
        _pictures = pictures;
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => DisplayPicturesScreen(pictures: _pictures),
          ),
        );
      });
    } catch (exception) {
      // Handle exception here
    }
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Take a picture'),
      ),
      child: CupertinoActivityIndicator(),
    );
  }
}

class DisplayPicturesScreen extends StatelessWidget {
  final List<String> pictures;

  const DisplayPicturesScreen({Key? key, required this.pictures})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Captured Pictures'),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var picture in pictures) Image.file(File(picture)),
          ],
        ),
      ),
    );
  }
}