import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/single_item.dart';
import 'model/edit_single_item.dart';
import '/pages/single_item/single_item_view.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/localization/language.dart';
import '/common/custom_widgets/all_custom_widgets.dart' show EventsContainer;

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
  const EditSingleItemPage({
    required SingleItem singleItem,
    bool draggable = true,
    bool showEvents = true,
    VoidCallback? onDismiss,
    void Function(SingleItem savedItem)? onSave,
    Key? key,
  })  : _item = singleItem,
        _draggable = draggable,
        _showEvents = showEvents,
        _onDismiss = onDismiss,
        _onSave = onSave,
        super(key: key);

  final SingleItem _item;
  final bool _draggable;
  final bool _showEvents;
  final VoidCallback? _onDismiss;
  final void Function(SingleItem savedItem)? _onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EditSingleItem item =
        ref.watch(Providers.editSingleItemControllerProvider(_item));
    final EditSingleItemController controller =
        ref.read(Providers.editSingleItemControllerProvider(_item).notifier);

    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;

    Widget editPageBody(ScrollController? scrollController) => Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(8.0, 52.0, 8.0, 0.0),
              controller: scrollController,
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
                                offset: item.title.length,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          placeholder: language.txtTitle,
                          prefix: const Icon(CupertinoIcons.pencil),
                          // TODO check, if not possible with just onSubmitted
                          // currently problematic, since switching textfields does not count as
                          // a submit and will reset the value
                          onChanged: (value) => controller.setTitle(value),
                          onSubmitted: (title) {
                            controller.setTitle(title);
                          },
                        ),
                        CupertinoTextField(
                          controller: TextEditingController.fromValue(
                            TextEditingValue(
                              text: item.description,
                              selection: TextSelection.collapsed(
                                offset: item.description.length,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          placeholder: language.txtDescription,
                          prefix: const Icon(CupertinoIcons.pencil),
                          onChanged: (value) =>
                              controller.setDescription(value),
                          onSubmitted: (description) {
                            controller.setDescription(description);
                          },
                        ),
                      ],
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
                    child: Container(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height / (24),
                      ),
                      margin: const EdgeInsets.all(8.0),
                      height: MediaQuery.of(context).size.height / 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: item.image,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      child: FloatingActionButton(
                        backgroundColor: theme.accentColor.withOpacity(0.5),
                        onPressed: () => {},
                        child: const Icon(CupertinoIcons.pencil, size: 35),
                      ),
                    ),
                  ),
                ),
                if (_showEvents)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.groupingColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: EventsContainer(
                        item: _item,
                        editable: true,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 52,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.navBarColor,
                  borderRadius: BorderRadius.vertical(
                    top: _draggable ? const Radius.circular(20) : Radius.zero,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      onPressed:
                          _onDismiss ?? () => Navigator.of(context).pop(),
                      child: Text(
                        language.lblCancel,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(language.titleEditItem,
                        style: TextStyle(color: theme.textColor, fontSize: 18)),
                    CupertinoButton(
                      onPressed: () async {
                        await controller.saveChanges().whenComplete(() {
                          if (_onSave == null) {
                            Navigator.of(context).pop();
                            return;
                          }
                          return;
                        });
                        _onSave?.call(item.toSingleItem());
                      },
                      child: Text(
                        language.lblSave,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );

    if (_draggable) {
      return makeDismissable(
        context: context,
        child: DraggableScrollableSheet(
          initialChildSize: 0.94,
          maxChildSize: 0.94,
          minChildSize: 0.7,
          snap: true,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: editPageBody(scrollController),
          ),
        ),
      );
    } else {
      return CupertinoPageScaffold(
        backgroundColor: theme.backgroundColor,
        child: SafeArea(
          child: editPageBody(null),
        ),
      );
    }
  }
}

abstract class EditSingleItemController extends StateNotifier<EditSingleItem>
    implements SingleItemControllerInterface {
  EditSingleItemController(super.state);

  Future<void> saveChanges();
}
