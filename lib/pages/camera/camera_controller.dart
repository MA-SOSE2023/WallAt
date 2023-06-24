import 'package:cunning_document_scanner/cunning_document_scanner.dart';

import 'camera_model.dart';
import 'camera_view.dart';
import '/router/router.dart';

class TakePictureControllerImpl extends TakePictureController {
  TakePictureControllerImpl() : super(const TakePictureModel(pictures: []));
  @override
  void takePicture() async {
    try {
      final List<String>? pictures = await CunningDocumentScanner.getPictures();
      if (pictures != null) {
        state = state.copyWith(pictures: pictures);
        Routers.globalRouterDelegate.beamToNamed('/camera/view', data: state);
      } else {
        state = state.copyWith(pictures: []);
      }
    } catch (exception) {
      // Handle exception here
      return null;
    }
  }

  @override
  void setPictures(List<String> pictures) {
    state = state.copyWith(pictures: pictures);
  }
}
