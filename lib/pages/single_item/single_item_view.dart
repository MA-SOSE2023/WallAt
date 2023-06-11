import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/provider.dart';
import 'full_screen_image_view.dart';
import 'model/single_item.dart';
import 'edit_single_item_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SingleItemPage extends ConsumerWidget {
  const SingleItemPage({required String id, Key? key})
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 30, bottom: 8), // Adjust the padding value here
            child: Text(
              item.title, // Add the item title here
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.6, // Set the height to half the screen height
            child: PictureContainer(
              image: controller.getImage().image,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImagePage(
                      imageProvider: controller.getImage().image,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InfoContainer(
                    text: item.description,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ActionButtons(itemId: _id),
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

class PictureContainer extends StatelessWidget {
  const PictureContainer({
    Key? key,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  final ImageProvider image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Image(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
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
  const ActionButtons({Key? key, required this.itemId}) : super(key: key);

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
          onPressed: () {
            // Handle share button logic
          },
          icon: FontAwesomeIcons.solidShareFromSquare,
        ),
        _buildActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditSingleItemPage(id: itemId),
              ),
            );
          },
          icon: FontAwesomeIcons.solidEdit,
        ),
        _buildActionButton(
          onPressed: () {
            // Handle delete button logic
          },
          icon: FontAwesomeIcons.solidTrashCan,
        ),
        _buildActionButton(
          onPressed: () {
            // Handle favorite button logic
          },
          icon: FontAwesomeIcons.heart,
        ),
      ],
    );
  }

  Widget _buildActionButton(
      {required VoidCallback onPressed, required IconData icon}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.grey.withOpacity(0.2);
              }
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed)) {
                return Colors.grey.withOpacity(0.4);
              }
              return null;
            },
          ),
        ),
        child: FaIcon(
          icon,
          color: Color.fromARGB(255, 22, 128, 199),
          size: 24,
        ),
      ),
    );
  }
}

abstract class SingleItemController extends StateNotifier<SingleItem> {
  SingleItemController(SingleItem state) : super(state);

  Image getImage();
  String getDescription();
  void setDescription(String description);
}
