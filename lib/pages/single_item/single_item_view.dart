import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/provider.dart';
import 'full_screen_image_view.dart';
import 'model/single_item.dart';
import 'edit_single_item_view.dart';
import 'model/item_event.dart';

String singleItemHeroTag(String id) {
  return "single_item_image$id";
}

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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(item.title),
      ),
      backgroundColor: Colors.grey[100],
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.6, // Set the height to half the screen height
              child: Hero(
                tag: singleItemHeroTag(_id),
                child: PictureContainer(
                  image: controller.getImage().image,
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => FullScreenImagePage(
                          itemId: _id,
                          imageProvider: controller.getImage().image,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: CupertinoButton(
                onPressed: onTap,
                child: const Icon(
                  CupertinoIcons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(
              onPressed: () {
                // Handle share button logic
              },
              icon: CupertinoIcons.share, // Use the Cupertino icon
            ),
            _buildActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => EditSingleItemPage(id: itemId),
                  ),
                );
              },
              icon: CupertinoIcons.pencil_circle, // Use the Cupertino icon
            ),
            _buildActionButton(
              onPressed: () {
                // Handle delete button logic
              },
              icon: CupertinoIcons.delete, // Use the Cupertino icon
            ),
            _buildActionButton(
              onPressed: () {
                // Handle favorite button logic
              },
              icon: CupertinoIcons.heart, // Use the Cupertino icon
            ),
          ],
        ));
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}

abstract class SingleItemController extends StateNotifier<SingleItem> {
  SingleItemController(SingleItem state) : super(state);

  DateTime? getSelectedDate();

  void setSelectedDate(DateTime date);

  Image getImage();

  void setImage(Image image);

  String getDescription();

  void setDescription(String description);

  String getTitle();

  void setTitle(String title);

  void addEvent(ItemEvent event);

  List<ItemEvent> getEvents();

  void removeEvent(ItemEvent event);

  void setCurrentDate(DateTime date);

  DateTime? getCurrentDate();
}
