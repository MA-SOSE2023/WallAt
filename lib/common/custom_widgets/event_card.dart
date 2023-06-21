import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gruppe4/pages/single_item/model/item_event.dart';

class EventCard extends StatelessWidget {
  const EventCard({required this.event, super.key});

  final ItemEvent event;

  @override
  Widget build(BuildContext context) {
    final DateTime date = event.date;
    final String description = event.description;
    return Column(
      children: [
        CupertinoListSection.insetGrouped(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            border: Border.all(
              color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemGroupedBackground, context),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.transparent,
          children: [
            CupertinoListTile.notched(
              title: Text(
                  '${date.day}/${date.month}/${date.year}  -  ${date.hour}:${date.minute}'),
              leading: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CupertinoColors.label,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: CupertinoColors.lightBackgroundGray,
                ),
                padding: const EdgeInsets.all(5),
                child: const Icon(
                  CupertinoIcons.alarm,
                  color: CupertinoColors.label,
                  size: 24,
                ),
              ),
              trailing: const Icon(
                CupertinoIcons.forward,
              ),
              leadingSize: 36,
              onTap: () {},
            ),
            CupertinoListTile.notched(
              title: SizedBox(
                height: MediaQuery.of(context).size.height / 15,
                child: Text(
                  description,
                  maxLines: 2,
                  style: CupertinoTheme.of(context).textTheme.pickerTextStyle,
                ),
              ),
              backgroundColor: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemGroupedBackground, context),
            ),
          ],
        ),
      ],
    );
  }
}

class PrefixWidget extends StatelessWidget {
  const PrefixWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Icon(icon, color: CupertinoColors.label),
        ),
        const SizedBox(width: 15),
        Text(title)
      ],
    );
  }
}
