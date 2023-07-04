import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'camera_model.dart';
import 'camera_view.dart';
import '/pages/single_item/model/single_item.dart';
import '/common/provider.dart';
import '/common/services/persistence/persistence_service.dart';
import '/router/router.dart';

class TakePictureControllerImpl extends TakePictureController {
  TakePictureControllerImpl(TakePictureModel? state, PersistenceService service)
      : _service = service,
        super(state ?? const TakePictureModel(pictures: []));

  final PersistenceService _service;

  @override
  void takePicture(WidgetRef ref) {
    try {
      Routers.globalRouterDelegate.beamToNamed('/camera/view',
          data: CunningDocumentScanner.getPictures()
              .then<SingleItem?>((pictures) async {
            if (pictures == null || pictures.isEmpty) {
              Routers.globalRouterDelegate.beamBack();
              return null;
            } else {
              SingleItem item = await storeAsItem(pictures);
              ref
                  .read(Providers.foldersControllerProvider(null).notifier)
                  .receiveItem(item);
              return item;
            }
          }));
    } catch (exception) {
      // TODO: Handle exception
      print(exception);
    }
  }

  @override
  void setPictures(List<String> pictures) {
    state = state.copyWith(pictures: pictures);
  }

  @override
  Future<SingleItem> storeAsItem(List<String> picturePaths) =>
      _service.createSingleItem(
        title: 'New Item',
        description: '',
        imagePath: picturePaths.first,
        isFavorite: false,
        parentFolderId: null,
      );
}
