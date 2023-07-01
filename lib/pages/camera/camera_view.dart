import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'camera_model.dart';

import '/pages/single_item/model/single_item.dart';
import '/pages/single_item/edit_single_item_view.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show FutureOptionBuilder, ErrorMessage, ActivityIndicator, EventsContainer;

class SaveItemScreen extends ConsumerWidget {
  final Future<SingleItem?> item;

  const SaveItemScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    return FutureOptionBuilder(
      future: item.then<SingleItem?>(
        (item) {
          if (item == null) {
            return null;
          }
          return ref.watch(Providers.editSingleItemControllerProvider(item));
        },
      ),
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
        final EditSingleItemController controller = ref
            .watch(Providers.editSingleItemControllerProvider(item).notifier);
        return CupertinoPageScaffold(
          backgroundColor: theme.backgroundColor,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: theme.navBarColor,
            middle: const Text("Save new Item"),
            leading: CupertinoButton(
              padding: const EdgeInsets.all(10),
              child: const SizedBox(
                  child: Text('Cancel', style: TextStyle(fontSize: 15))),
              onPressed: () {
                // Cancel the item
                ref
                    .read(Providers.singleItemControllerProvider(item.id)
                        .notifier)
                    .deleteItem(ref);
                Navigator.of(context).pop();
              },
            ),
            trailing: CupertinoButton(
              padding: const EdgeInsets.all(10),
              child: const Text('Save', style: TextStyle(fontSize: 15)),
              onPressed: () {
                controller.saveChanges();
                // Save the item
                context.beamToNamed('/item/move', data: item);
              },
            ),
          ),
          child: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.groupingColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CupertinoFormSection.insetGrouped(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: theme.backgroundColor),
                        margin: const EdgeInsets.all(10),
                        backgroundColor: Colors.transparent,
                        children: [
                          CupertinoTextField(
                              controller: TextEditingController.fromValue(
                                  TextEditingValue(
                                      text: item.title,
                                      selection: TextSelection.collapsed(
                                          offset: item.title.length))),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              placeholder: 'Title',
                              prefix: const Icon(CupertinoIcons.pencil),
                              onChanged: (value) => {
                                    controller.setTitle(value),
                                  }),
                          CupertinoTextField(
                            controller: TextEditingController.fromValue(
                                TextEditingValue(
                                    text: item.description,
                                    selection: TextSelection.collapsed(
                                        offset: item.description.length))),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            placeholder: "Description",
                            prefix: const Icon(CupertinoIcons.pencil),
                            onChanged: (value) => {
                              controller.setDescription(value),
                            },
                          ),
                        ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // @TODO: add functionality
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.groupingColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: item.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.groupingColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: EventsContainer(item: item, editable: true),
                  ),
                ),
              ],
            ),
          ),
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
