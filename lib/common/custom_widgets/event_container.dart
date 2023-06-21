import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/single_item/single_item_view.dart';
import '/common/custom_widgets/calendar_button.dart';
import '/common/provider.dart';

class EventsContainer extends ConsumerWidget {
  const EventsContainer({Key? key, required this.id, required this.editable})
      : super(key: key);

  final String id;
  final bool editable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          ...controller.getEvents().map((event) {
            return CupertinoListTile(
              trailing: editable
                  ? CupertinoButton(
                      onPressed: () {
                        controller.removeEvent(event);
                      },
                      child: const Icon(CupertinoIcons.minus_circled),
                    )
                  : null,
              title: Text(
                event.description,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                '${event.date.day}/${event.date.month}/${event.date.year}',
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
