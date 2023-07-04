import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'camera_model.dart';

import '/pages/single_item/model/single_item.dart';
import '/pages/single_item/edit_single_item_view.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show FutureOptionBuilder, ErrorMessage, ActivityIndicator;

class SaveItemScreen extends ConsumerWidget {
  final Future<SingleItem?> _futureItem;

  const SaveItemScreen({Key? key, required Future<SingleItem?> item})
      : _futureItem = item,
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    return FutureOptionBuilder(
      future: _futureItem,
      loading: () => const CupertinoPageScaffold(
        child: ActivityIndicator(),
      ),
      error: (_) => const CupertinoPageScaffold(
        child:
            ErrorMessage(message: "Something went wrong.\nPlease try again."),
      ),
      success: (item) {
        if (item == null) {
          return CupertinoPageScaffold(
            navigationBar:
                CupertinoNavigationBar(backgroundColor: theme.navBarColor),
            backgroundColor: theme.backgroundColor,
            child: const ErrorMessage(
                message: "Images could not be captured.\nPlease try again."),
          );
        }
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
