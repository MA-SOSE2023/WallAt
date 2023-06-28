import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/single_item/single_item_view.dart';
import '/pages/single_item/model/single_item.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show FutureOptionListBuilder, CalendarButton;

class EventsContainer extends ConsumerWidget {
  const EventsContainer({Key? key, required this.id, required this.editable})
      : super(key: key);

  final int id;
  final bool editable;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    tz.initializeTimeZones();
    final Future<SingleItem> item = editable
        ? ref.watch(Providers.editSingleItemControllerProvider(id))
        : ref.watch(Providers.singleItemControllerProvider(id));
    final SingleItemController controller = editable
        ? ref.watch(Providers.editSingleItemControllerProvider(id).notifier)
        : ref.watch(Providers.singleItemControllerProvider(id).notifier);
    return FutureOptionListBuilder(
      future: item.then((item) => item.events),
      emptyMessage: 'No events',
      success: (events) => CupertinoListSection.insetGrouped(
        margin: const EdgeInsets.all(8),
        backgroundColor: Colors.transparent,
        decoration: BoxDecoration(
            color: CupertinoDynamicColor.resolve(
                CupertinoColors.systemBackground, context)),
        header:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Events"),
          if (editable) CalendarButton(id: id),
        ]),
        children: events.map((itemEvent) {
          return CupertinoListTile(
            trailing: editable
                ? CupertinoButton(
                    onPressed: () {
                      controller.removeEvent(itemEvent);
                    },
                    child: const Icon(CupertinoIcons.minus_circled),
                  )
                : null,
            title: Text(
              itemEvent.event.title!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            subtitle: Text(
              'from: ${DateFormat('dd/MM/yyyy - HH:mm').format(itemEvent.event.start!)}\nto: ${DateFormat('dd/MM/yyyy - HH:mm').format(itemEvent.event.end!)}',
              maxLines: 2,
            ),
          );
        }).toList(),
      ),
    );
  }
}
