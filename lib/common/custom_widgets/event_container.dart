import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/provider.dart';
import '../../pages/single_item/single_item_view.dart';

class EventsContainer extends StatelessWidget {
  const EventsContainer(
      {Key? key, required this.controller, required this.editable})
      : super(key: key);

  final SingleItemController controller;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      backgroundColor: Colors.transparent,
      header: const Text('Events'),
      children: [
        if (controller.getEvents().isNotEmpty)
          ...controller.getEvents().map((event) {
            return CupertinoListTile(
              trailing: editable
                  ? CupertinoButton(
                      onPressed: () {
                        controller.removeEvent(event);
                      },
                      padding: EdgeInsets.zero,
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
          const Text('No events'),
      ],
    );
  }
}
