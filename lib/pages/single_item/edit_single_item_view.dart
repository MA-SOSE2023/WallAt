import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/pages/single_item/single_item_view.dart';

import 'model/single_item.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show EventsContainer, FutureOptionBuilder;

Widget makeDismissable(
        {required BuildContext context, required Widget child}) =>
    GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );

class EditSingleItemPage extends ConsumerWidget {
  const EditSingleItemPage({required int singleItemId, Key? key})
      : _id = singleItemId,
        super(key: key);

  final int _id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<SingleItem> item =
        ref.watch(Providers.editSingleItemControllerProvider(_id));
    final EditSingleItemController controller =
        ref.read(Providers.editSingleItemControllerProvider(_id).notifier);

    return makeDismissable(
      context: context,
      child: DraggableScrollableSheet(
        initialChildSize: 0.94,
        maxChildSize: 0.94,
        minChildSize: 0.7,
        snap: true,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              FutureOptionBuilder(
                loading: () => const Align(
                    alignment: Alignment.center,
                    child: CupertinoActivityIndicator()),
                error: (_) => const Align(
                  alignment: Alignment.center,
                  child: Text(
                      "Something went wrong while loading this item.\nPlease reload."),
                ),
                future: item,
                success: (item) => ListView(
                  padding: const EdgeInsets.fromLTRB(8.0, 52.0, 8.0, 0.0),
                  controller: scrollController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: CupertinoDynamicColor.resolve(
                              CupertinoColors.systemGrey5, context),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CupertinoFormSection.insetGrouped(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CupertinoDynamicColor.resolve(
                                    CupertinoColors.systemBackground, context)),
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
                            color: CupertinoDynamicColor.resolve(
                                CupertinoColors.systemGrey5, context),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            height: MediaQuery.of(context).size.height / 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: item.image,
                                fit: BoxFit.fitWidth,
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
                              color: CupertinoDynamicColor.resolve(
                                  CupertinoColors.systemGrey5, context),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                                EventsContainer(id: item.id, editable: true))),
                  ],
                ),
              ),
              SizedBox(
                height: 52,
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).barBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: const Text('Cancel',
                            style: TextStyle(fontSize: 14)),
                        onPressed: () {
                          // Cancel the edit
                          Navigator.of(context).pop();
                        },
                      ),
                      Text('Edit Item',
                          style: TextStyle(
                              color: CupertinoDynamicColor.resolve(
                                  CupertinoColors.label, context),
                              fontSize: 18)),
                      CupertinoButton(
                          child: const Text('Save',
                              style: TextStyle(fontSize: 14)),
                          onPressed: () {
                            controller.saveChanges(ref);
                            // Save the item
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class EditSingleItemController extends SingleItemController {
  EditSingleItemController(Future<SingleItem> state) : super(state);

  DateTime? getSelectedDate();

  void setSelectedDate(DateTime date);

  void saveChanges(WidgetRef ref);
}
