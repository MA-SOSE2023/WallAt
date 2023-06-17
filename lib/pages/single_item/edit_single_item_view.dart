import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/pages/single_item/single_item_view.dart';
import '../../common/provider.dart';
import 'model/single_item.dart';

class EditSingleItemPage extends ConsumerWidget {
  const EditSingleItemPage({required String id, Key? key})
      : _id = id,
        super(key: key);

  final String _id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                          controller: TextEditingController(
                              text: controller.getTitle()),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: controller.getImage(),
                        ),
                        Positioned(
                          right: 10,
                          top: 80,
                          child: CupertinoButton(
                            onPressed: () {
                              // Edit icon button action
                            },
                            padding: EdgeInsets.zero,
                            child: const Icon(CupertinoIcons.pencil),
                          ),
                        ),
                      ],
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
                    controller: TextEditingController(
                        text: controller.getDescription()),
                    onChanged: (value) {
                      controller
                          .setDescription(value); // Update the local state
                    },
                    hintText: 'Description',
                    icon: CupertinoIcons.pencil,
                  ),
                ),
              ),
              CupertinoButton(
                alignment: Alignment.bottomRight,
                onPressed: () {
                  _showCalendarPopup(context);
                },
                child: Icon(CupertinoIcons.calendar),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showCalendarPopup(BuildContext context) {
    DateTime? selectedDate;
    String description = '';

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Select Date'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                onPressed: () async {
                  final DateTime? pickedDate = await showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 216,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime.now(),
                          minimumDate: DateTime(1900),
                          maximumDate: DateTime(2100),
                          onDateTimeChanged: (DateTime? dateTime) {
                            selectedDate = dateTime;
                          },
                        ),
                      );
                    },
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: Text(selectedDate != null
                    ? 'Selected Date: ${selectedDate.toString()}'
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
                if (selectedDate != null) {
                  // Use the selected date and description as needed
                  print('Selected Date: $selectedDate');
                  print('Description: $description');
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void setState(Null Function() param0) {}
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
        CupertinoButton(
          onPressed: () {
            // Edit icon button action
          },
          child: Icon(icon),
        ),
      ],
    );
  }
}
