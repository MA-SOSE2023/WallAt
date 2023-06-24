import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/single_item/single_item_view.dart';
import 'calendar_button/calendar_button.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:intl/intl.dart';

import 'package:timezone/data/latest.dart' as tz;

import '/common/provider.dart';
import '/pages/single_item/single_item_view.dart';

class EventsContainer extends ConsumerWidget {
  const EventsContainer({Key? key, required this.id, required this.editable})
      : super(key: key);

  final String id;
  final bool editable;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    tz.initializeTimeZones();
    final SingleItemController controller = editable
        ? ref.watch(Providers.editSingleItemControllerProvider(id).notifier)
        : ref.watch(Providers.singleItemControllerProvider(id).notifier);
    return CupertinoListSection.insetGrouped(
      backgroundColor: Colors.transparent,
      header: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Events"),
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
                itemEvent.event.description!,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              subtitle: Text(
                'from ${DateFormat('dd/MM/yyyy - HH:mm').format(itemEvent.event.start!)} to ${DateFormat('dd/MM/yyyy - HH:mm').format(itemEvent.event.end!)}',
              ),
            );
          }).toList()
        else
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(style: TextStyle(fontSize: 14), 'No events'),
          ),
      ],
    );
  }
}
