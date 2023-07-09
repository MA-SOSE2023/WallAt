import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'camera_model.dart';

import '/pages/single_item/model/single_item.dart';
import '/pages/single_item/edit_single_item_view.dart';
import '/common/provider.dart';
import '/common/localization/language.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show FutureOptionBuilder, ErrorMessage, ActivityIndicator;

class SaveItemScreen extends ConsumerWidget {
  final Future<SingleItem?> _futureItem;

  const SaveItemScreen({Key? key, required Future<SingleItem?> item})
      : _futureItem = item,
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;
    return FutureOptionBuilder(
      future: _futureItem,
      loading: () => const CupertinoPageScaffold(
        child: ActivityIndicator(),
      ),
      error: (_) => CupertinoPageScaffold(
        child: ErrorMessage(message: language.errGenericLoad),
      ),
      success: (item) {
        return EditSingleItemPage(
          singleItem: item,
          draggable: false,
          showEvents: false,
          onDismiss: () {
            // Cancel the item
            ref
                .read(Providers.singleItemControllerProvider(item.id).notifier)
                .deleteItem();
            Navigator.of(context).pop();
          },
          onSave: (savedItem) {
            // Save the item
            Beamer.of(context)
                .beamToReplacementNamed('/item/move', data: savedItem);
          },
        );
      },
    );
  }
}

abstract class TakePictureController extends StateNotifier<TakePictureModel> {
  TakePictureController(TakePictureModel state) : super(state);

  void takePicture(WidgetRef ref);
  void setPictures(List<String> pictures);

  Future<SingleItem> storeAsItem(List<String> picturePaths);
}
