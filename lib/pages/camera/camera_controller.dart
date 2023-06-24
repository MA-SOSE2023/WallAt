import 'package:cunning_document_scanner/cunning_document_scanner.dart';

class TakePictureController {
  
  Future<List<String>?> takePicture() async {
    try {
      final List<String>? pictures =
          await CunningDocumentScanner.getPictures();
      return pictures;
    } catch (exception) {
      // Handle exception here
      return null;
    }
  }
  
}
