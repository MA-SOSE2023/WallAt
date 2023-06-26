import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/single_item/single_item_view.dart';
import 'calendar_button/calendar_button.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import '/common/provider.dart';

class EventsContainer extends ConsumerWidget {
  const EventsContainer({Key? key, required this.id, required this.editable})
      : super(key: key);

  final int id;
  final bool editable;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    tz.initializeTimeZones();
    final SingleItemController controller = editable
        ? ref.watch(Providers.editSingleItemControllerProvider(id).notifier)
        : ref.watch(Providers.singleItemControllerProvider(id).notifier);
    return CupertinoListSection.insetGrouped(
      margin: const EdgeInsets.all(8),
      backgroundColor: Colors.transparent,
      decoration: BoxDecoration(
          color: CupertinoDynamicColor.resolve(
              CupertinoColors.systemBackground, context)),
      header: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text("Events"),
        if (editable) CalendarButton(id: id),
      ]),
      children: [
        if (controller.getEvents().isNotEmpty)
          ...controller.getEvents().map((itemEvent) {
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
          }).toList()
        else
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                style: TextStyle(
                    color: CupertinoDynamicColor.resolve(
                        CupertinoColors.label, context),
                    fontSize: 14),
                'No events'),
          ),
      ],
    );
  }
}
