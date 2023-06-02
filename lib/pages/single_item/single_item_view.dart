import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model/single_item.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SingleItemPage(),
    );
  }
}

//@TODO: include this into the application
const exampleSingleItem = SingleItem(
  title: 'Example Title',
  description: 'Example Description',
  image: 'assets/images/example_document.png',
);

class SingleItemPage extends ConsumerWidget {
  const SingleItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                PictureContainer(
                  pictureLink: exampleSingleItem.image,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InfoContainer(
                    text: exampleSingleItem.description,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ActionButtons(),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

class PictureContainer extends StatefulWidget {
  const PictureContainer({
    Key? key,
    required this.pictureLink,
  }) : super(key: key);

  final String pictureLink;

  @override
  _PictureContainerState createState() => _PictureContainerState();
}

class _PictureContainerState extends State<PictureContainer> {
  bool isFullscreen = false;

  @override
  Widget build(BuildContext context) {
    final double itemImageHeight = MediaQuery.of(context).size.height / 1.5;
    if (isFullscreen) {
      return GestureDetector(
        onTap: () {
          setState(() {
            isFullscreen = false;
          });
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Image.asset(
              widget.pictureLink,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            isFullscreen = true;
          });
        },
        child: Container(
          height: itemImageHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset(
              widget.pictureLink,
            ),
          ),
        ),
      );
    }
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({Key? key, required this.text}) : super(key: key);

  final String text;

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
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
          onPressed: () {},
          icon: Icons.share,
        ),
        _buildActionButton(
          onPressed: () {},
          icon: Icons.edit,
        ),
        _buildActionButton(
          onPressed: () {},
          icon: Icons.delete,
        ),
        _buildActionButton(
          onPressed: () {},
          icon: Icons.favorite,
        ),
      ],
    );
  }

  Widget _buildActionButton(
      {required VoidCallback onPressed, required IconData icon}) {
    return CircleAvatar(
      backgroundColor: Colors.blue,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: Colors.white,
      ),
    );
  }
}

abstract class SingleItemController extends StateNotifier<SingleItem> {
  SingleItemController(SingleItem state) : super(state);

  Image getImage();
  String getDescription();
}
