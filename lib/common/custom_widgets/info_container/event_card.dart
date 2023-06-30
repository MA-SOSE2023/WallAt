import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/pages/single_item/model/item_event.dart';
import '/common/theme/custom_theme_data.dart';

class EventCard extends ConsumerWidget {
  const EventCard({required this.event, super.key});

  final ItemEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TZDateTime date = event.event.start!;
    final String description = event.event.description ?? '';

    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: theme.gradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child:
            CupertinoListSection.insetGrouped(
              margin: EdgeInsets.fromLTRB(2, 2, 2, 0),
              decoration: BoxDecoration(
                gradient: theme.gradient,
              ),
              backgroundColor: Colors.transparent,
              children: [
                CupertinoListTile.notched(
                  backgroundColor: theme.backgroundColor,
                  title: Text(
                      '${date.day}/${date.month}/${date.year}  -  ${date.hour}:${date.minute}'),
                  leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.groupingColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: theme.backgroundColor,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      CupertinoIcons.alarm,
                      color: theme.accentColor,
                      size: 24,
                    ),
                  ),
                  trailing: const Icon(
                    CupertinoIcons.forward,
                  ),
                  leadingSize: 36,
                  onTap: () {
                    ref
                        .read(Providers.singleItemControllerProvider(event.parentId)
                            .notifier)
                        .navigateToThisItem();
                  },
                ),
                CupertinoListTile.notched(
                  title: Container(
                    height: MediaQuery.of(context).size.height / 15,
                    child: Text(
                      description,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
