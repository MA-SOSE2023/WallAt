import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/pages/single_item/single_item_view.dart';
import '../../common/provider.dart';
import 'model/single_item.dart';
import 'model/item_event.dart';

import '../../common/custom_widgets/all_custom_widgets.dart';

class EditSingleItemPage extends ConsumerWidget {
  const EditSingleItemPage({required String id, Key? key})
      : _id = id,
        super(key: key);

  final String _id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SingleItem item =
        ref.watch(Providers.singleItemControllerProvider(_id));
    final SingleItemController controller =
        ref.read(Providers.singleItemControllerProvider(_id).notifier);

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Edit item'),
      ),
      backgroundColor: Colors.grey[100],
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25.0, top: 20),
                child: Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFieldWithIcon(
                          controller: TextEditingController(text: item.title),
                          onChanged: (value) {
                            controller
                                .setTitle(value); // Update the local state
                          },
                          hintText: 'Title',
                          icon: CupertinoIcons.pencil,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25.0, top: 20),
                child: Text(
                  'Image',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Open gallery, select image, and save it
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: controller.getImage().image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25.0, top: 20),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFieldWithIcon(
                    controller: TextEditingController(text: item.description),
                    onChanged: (value) {
                      controller
                          .setDescription(value); // Update the local state
                    },
                    hintText: 'Description',
                    icon: CupertinoIcons.pencil,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: EventsContainer(
                          controller: controller, editable: true))),
              CalendarButton(id: _id), // Pass the ID to the button widget
            ],
          ),
        ),
      ),
    );
  }
}

class _CalendarButtonState extends ConsumerState<CalendarButton> {
  String description = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: const Icon(CupertinoIcons.calendar),
      onPressed: () => showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer(
            builder: (context, ref, _) {
              final DateTime? currentDate = ref
                  .watch(Providers.singleItemControllerProvider(widget.id))
                  .currentSelectedDate;

              return CupertinoAlertDialog(
                title: Text('Select Date'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoButton(
                      onPressed: () async {
                        final DateTime? pickedDate =
                            await showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 216,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color: Colors.white),
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: DateTime.now(),
                                  minimumDate: DateTime(1900),
                                  maximumDate: DateTime(2100),
                                  onDateTimeChanged: (DateTime? dateTime) {
                                    ref
                                        .read(Providers
                                                .singleItemControllerProvider(
                                                    widget.id)
                                            .notifier)
                                        .setCurrentDate(dateTime!);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(currentDate != null
                          ? '${currentDate.day}/${currentDate.month}/${currentDate.year}'
                          : 'Select Date'),
                    ),
                    SizedBox(height: 20),
                    CupertinoTextField(
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      // Do something with the selected date and description
                      if (currentDate != null && description.isNotEmpty) {
                        // Use the selected date and description as needed
                        ItemEvent newEvent = ItemEvent(
                          date: currentDate,
                          description: description,
                        );

                        ref
                            .read(Providers.singleItemControllerProvider(
                                    widget.id)
                                .notifier)
                            .addEvent(newEvent);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class CalendarButton extends ConsumerStatefulWidget {
  const CalendarButton({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  _CalendarButtonState createState() => _CalendarButtonState();
}

class _ListEventButtonState extends ConsumerState<ListEventButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: const Icon(CupertinoIcons.list_bullet),
      onPressed: () => showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer(
            builder: (context, ref, _) {
              final List<ItemEvent> events = ref
                  .watch(Providers.singleItemControllerProvider(widget.id))
                  .events;

              return CupertinoAlertDialog(
                title: const Text('Event List'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (events.isNotEmpty)
                      SizedBox(
                        height: 300, // Adjust the height as needed
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            final ItemEvent event = events[index];
                            return CupertinoListTile(
                              title: Text(event.description),
                              subtitle: Text(
                                '${event.date.day}/${event.date.month}/${event.date.year}',
                              ),
                              trailing: CupertinoButton(
                                onPressed: () {
                                  ref
                                      .read(Providers
                                              .singleItemControllerProvider(
                                                  widget.id)
                                          .notifier)
                                      .removeEvent(event);
                                },
                                padding: EdgeInsets.zero,
                                child: const Icon(CupertinoIcons.minus_circled),
                              ),
                            );
                          },
                        ),
                      )
                    else
                      const Text('No events'),
                  ],
                ),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class ListEventButton extends ConsumerStatefulWidget {
  const ListEventButton({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  _ListEventButtonState createState() => _ListEventButtonState();
}

class TextFieldWithIcon extends StatelessWidget {
  const TextFieldWithIcon({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoTextField(
            controller: controller,
            onChanged: onChanged,
            placeholder: hintText,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          ),
        ),
        Icon(icon),
      ],
    );
  }
}
