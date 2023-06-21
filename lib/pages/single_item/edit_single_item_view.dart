import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/pages/single_item/single_item_view.dart';
import '../../common/provider.dart';
import 'model/item_event.dart';

import '../../common/custom_widgets/all_custom_widgets.dart';
import 'model/single_item.dart';

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
  const EditSingleItemPage({required String id, Key? key})
      : _id = id,
        super(key: key);

  final String _id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SingleItem item =
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
              ListView(
                padding: const EdgeInsets.fromLTRB(8.0, 52.0, 8.0, 0.0),
                controller: scrollController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CupertinoFormSection.insetGrouped(
                          margin: EdgeInsets.all(20),
                          backgroundColor: Colors.transparent,
                          children: [
                            CupertinoTextField(
                                controller: TextEditingController.fromValue(
                                    TextEditingValue(
                                        text: controller.getTitle(),
                                        selection: TextSelection.collapsed(
                                            offset:
                                                controller.getTitle().length))),
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
                                      text: controller.getDescription(),
                                      selection: TextSelection.collapsed(
                                          offset: controller
                                              .getDescription()
                                              .length))),
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
                      // Open gallery, select image, and save it
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: controller.getImage().image,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: EventsContainer(id: _id, editable: true))),
                ],
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
                      const Text('Edit Item', style: TextStyle(fontSize: 18)),
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

class TextFieldWithIcon extends StatelessWidget {
  const TextFieldWithIcon({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoTextField(
            controller: controller,
            onChanged: onChanged,
            placeholder: hintText,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          ),
        ),
        Icon(icon),
      ],
    );
  }
}

abstract class EditSingleItemController extends SingleItemController {
  EditSingleItemController(SingleItem state) : super(state);

  DateTime? getSelectedDate();

  void setSelectedDate(DateTime date);

  void saveChanges(WidgetRef ref);
}
