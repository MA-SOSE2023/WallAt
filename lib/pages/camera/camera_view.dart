import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:gruppe4/pages/single_item/edit_single_item_view.dart';

import 'camera_model.dart';

import '/pages/single_item/model/single_item.dart';
import '/common/provider.dart';
import '/common/custom_widgets/event_container.dart';
import '/common/theme/custom_theme_data.dart';

// currently uses the mock item that is create in the single_item_controller
class SaveItemScreen extends ConsumerWidget {
  final TakePictureModel model;

  const SaveItemScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    int usedMockID = 1;
    // create new single item in the database and use the id to create a new
    // EditSingleItemController

    final EditSingleItemController controller = ref
        .read(Providers.editSingleItemControllerProvider(usedMockID).notifier);

    final Future<SingleItem> item =
        ref.watch(Providers.editSingleItemControllerProvider(usedMockID));

    Future<void>.delayed(Duration.zero, () {
      controller.setImage(Image.file(File(model.pictures[0])));
    });

    return CupertinoPageScaffold(
      backgroundColor: theme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
          backgroundColor: theme.navBarColor,
          middle: const Text("Save new Item"),
          trailing: CupertinoButton(
              child: const Text('Save', style: TextStyle(fontSize: 15)),
              onPressed: () {
                controller.saveChanges(ref);
                // Save the item
                Navigator.of(context).pop();
              })),
      child: SafeArea(
        child: FutureBuilder(
          future: item,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Placeholder();
            } else {
              final SingleItem item = snapshot.data!;

              return ListView(
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
                          child:
                              EventsContainer(id: usedMockID, editable: true))),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

abstract class TakePictureController extends StateNotifier<TakePictureModel> {
  TakePictureController(TakePictureModel state) : super(state);

  void takePicture();
  void setPictures(List<String> pictures);
}
