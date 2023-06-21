import 'package:flutter/cupertino.dart';

class EventCard extends StatelessWidget {
  const EventCard({required this.date, required this.description, super.key});

  final DateTime date;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: CupertinoColors.label,
                width: 2,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.label,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: CupertinoColors.lightBackgroundGray,
                  ),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.fromLTRB(15, 10, 25, 10),
                  child: const Icon(
                    CupertinoIcons.alarm,
                    color: CupertinoColors.label,
                  ),
                ),
                Text(
                  '${date.day}/${date.month}/${date.year}  -  ${date.hour}:${date.minute}',
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: CupertinoColors.label,
                width: 2,
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              color: CupertinoColors.systemGrey,
            ),
            padding: const EdgeInsets.all(15),
            child: Text(
              description,
              style: CupertinoTheme.of(context).textTheme.pickerTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
