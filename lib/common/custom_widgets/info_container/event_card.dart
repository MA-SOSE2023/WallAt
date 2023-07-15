import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/single_item/model/item_event.dart';
import '/common/provider.dart';
import '/common/localization/language.dart';
import '/common/theme/custom_theme_data.dart';

class EventCard extends ConsumerWidget {
  const EventCard({required ItemEvent event, super.key}) : _event = event;

  final ItemEvent _event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TZDateTime date = _event.event.start!;
    final String description = _event.event.description ?? '';
    final String title = _event.event.title ?? 'Event';

    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: theme.gradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CupertinoListSection.insetGrouped(
            margin: const EdgeInsets.fromLTRB(2, 2, 2, 0),
            decoration: BoxDecoration(
              gradient: theme.gradient,
            ),
            backgroundColor: Colors.transparent,
            children: [
              CupertinoListTile.notched(
                backgroundColor: theme.backgroundColor,
                title: Text(language.formatDateTime(date)),
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
                      .read(Providers.singleItemControllerProvider(
                              _event.parentId)
                          .notifier)
                      .navigateToThisItem();
                },
              ),
              CupertinoListTile.notched(
                title: SizedBox(
                  height: 45,
                  child: Text(
                    description.isNotEmpty ? description : title,
                    maxLines: 2,
                    style: const TextStyle(
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
