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
    final SingleItem item =
        ref.watch(Providers.singleItemControllerProvider(_id));
    final SingleItemController controller =
        ref.read(Providers.singleItemControllerProvider(_id).notifier);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: EditableTitleContainer(
              initialText: item.title,
              onTextChanged: (text) {
                controller.setTitle(text);
              },
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                PictureContainer(
                  image: controller.getImage().image,
                  onTap: () {
                    // open gallery, select image and save it
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: EditableInfoContainer(
                    initialText: item.description,
                    onTextChanged: (text) {
                      controller.setDescription(text);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  // Handle button onPressed
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

class EditableTitleContainer extends StatefulWidget {
  const EditableTitleContainer({
    Key? key,
    required this.initialText,
    required this.onTextChanged,
  }) : super(key: key);

  final String initialText;
  final Function(String) onTextChanged;

  @override
  _EditableTitleContainerState createState() => _EditableTitleContainerState();
}

class _EditableTitleContainerState extends State<EditableTitleContainer> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 11,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                onChanged: widget.onTextChanged,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditableInfoContainer extends StatefulWidget {
  const EditableInfoContainer({
    Key? key,
    required this.initialText,
    required this.onTextChanged,
  }) : super(key: key);

  final String initialText;
  final Function(String) onTextChanged;

  @override
  _EditableInfoContainerState createState() => _EditableInfoContainerState();
}

class _EditableInfoContainerState extends State<EditableInfoContainer> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 11,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: TextField(
              controller: _textEditingController,
              onChanged: widget.onTextChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                // Handle button onPressed
              },
            ),
          ),
        ),
      ],
    );
  }
}
