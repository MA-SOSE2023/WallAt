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
              GestureDetector(
                onTap: () {
                  _showCalendarPopup(context); // Open calendar popup
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Calendar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCalendarPopup(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CupertinoTextField(
                  placeholder: 'Start Date',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CupertinoTextField(
                  placeholder: 'End Date',
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  // Close the calendar popup
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
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
