import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/single_item/model/item_event.dart';
import '/pages/single_item/single_item_view.dart';
import '/pages/single_item/model/single_item.dart';
import '/pages/single_item/edit_single_item_view.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show AsyncOptionBuilder, CalendarButton;

Widget _eventSection({
  required CalendarButton calendarButton,
  required List<Widget> children,
  required CustomThemeData theme,
}) =>
    CupertinoListSection.insetGrouped(
        margin: const EdgeInsets.all(8),
        backgroundColor: Colors.transparent,
        decoration: BoxDecoration(
          color: theme.primaryColor,
        ),
        header:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Events"),
          calendarButton,
        ]),
        children: children.isEmpty
            ? [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "No events",
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.textColor,
                    ),
                  ),
                )
              ]
            : children);

Widget _eventTile({
  required ItemEvent event,
  required Function(ItemEvent event) deleteEvent,
  bool editable = false,
}) {
  return CupertinoListTile(
    trailing: editable
        ? CupertinoButton(
            onPressed: () {
              deleteEvent(event);
            },
            child: const Icon(CupertinoIcons.minus_circled),
          )
        : null,
    title: Text(
      event.event.title ?? '',
      style: const TextStyle(
        fontSize: 12,
      ),
    ),
    subtitle: Text(
      'from: ${DateFormat('dd/MM/yyyy - HH:mm').format(event.event.start!)}\nto: ${DateFormat('dd/MM/yyyy - HH:mm').format(event.event.end!)}',
      maxLines: 2,
    ),
  );
}

class EventsContainer extends ConsumerWidget {
  const EventsContainer(
      {Key? key, required SingleItem item, required this.editable})
      : _item = item,
        super(key: key);

  final SingleItem _item;
  final bool editable;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    tz.initializeTimeZones();

    return editable
        ? _EditEventsContainer(item: _item)
        : _EventsContainer(item: _item);
  }
}

class _EventsContainer extends ConsumerWidget {
  const _EventsContainer({required SingleItem item, Key? key})
      : _item = item,
        super(key: key);

  final SingleItem _item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    final AsyncValue<SingleItem?> item =
        ref.watch(Providers.singleItemControllerProvider(_item.id));
    final SingleItemController controller =
        ref.read(Providers.singleItemControllerProvider(_item.id).notifier);

    return AsyncOptionBuilder(
      future: item,
      initialData: _item,
      errorMessage: "Failed to load events.\nTry re-opening this page.",
      success: (item) {
        return _eventSection(
          calendarButton: CalendarButton(
            onSave: (event) =>
                controller.addEvent(event: event, parentId: item.id),
          ),
          theme: theme,
          children: item.events.map((itemEvent) {
            return _eventTile(
                event: itemEvent, deleteEvent: controller.removeEvent);
          }).toList(),
        );
      },
    );
  }
}

class _EditEventsContainer extends ConsumerWidget {
  const _EditEventsContainer({required SingleItem item, Key? key})
      : _item = item,
        super(key: key);

  final SingleItem _item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    final SingleItem item = ref
        .watch(Providers.editSingleItemControllerProvider(_item))
        .toSingleItem();
    final EditSingleItemController controller =
        ref.read(Providers.editSingleItemControllerProvider(_item).notifier);

    return _eventSection(
      calendarButton: CalendarButton(
          onSave: (event) =>
              controller.addEvent(event: event, parentId: item.id)),
      theme: theme,
      children: item.events.map((itemEvent) {
        return _eventTile(
          event: itemEvent,
          deleteEvent: controller.removeEvent,
          editable: true,
        );
      }).toList(),
    );
  }
}
