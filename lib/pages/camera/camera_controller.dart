import 'package:cunning_document_scanner/cunning_document_scanner.dart';

import 'camera_model.dart';
import 'camera_view.dart';

class TakePictureControllerImpl extends TakePictureController {
  TakePictureControllerImpl() : super(const TakePictureModel(pictures: []));
  @override
  Future<List<String>?> takePicture() async {
    try {
      final List<String>? pictures = await CunningDocumentScanner.getPictures();
      return pictures;
    } catch (exception) {
      // Handle exception here
      return null;
    }
  }

  @override
  void setPictures(List<String> pictures) {
    // TODO: implement setPictures
  }
}
