import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_share/social_share.dart';

import '../../common/provider.dart';
import 'full_screen_image_view.dart';
import 'edit_single_item_view.dart';
import 'model/single_item.dart';
import 'model/item_event.dart';
import '/common/custom_widgets/all_custom_widgets.dart' show EventsContainer;

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
      child: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height /
                      2, // Set the height to half the screen height
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
                            fullscreenDialog: true,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: InfoContainer(
                      text: item.description,
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
                        child: EventsContainer(id: _id, editable: false))),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: CupertinoTheme.of(context).barBackgroundColor,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ActionButtons(itemId: _id, controller: controller),
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
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: CupertinoTheme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
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

class ActionButtons extends ConsumerWidget {
  const ActionButtons(
      {Key? key, required this.itemId, required this.controller})
      : super(key: key);

  final String itemId;
  final SingleItemController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
          onPressed: () {
            SocialShare.shareOptions(
              "Hello world",
              //@TODO: add the correct image path
            );
          },
          icon: CupertinoIcons.share, // Use the Cupertino icon
        ),
        _buildActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => EditSingleItemPage(id: itemId),
            );
          },
          icon: CupertinoIcons.slider_horizontal_3, // Use the Cupertino icon
        ),
        _buildActionButton(
          onPressed: () {
            // Handle delete button logic
          },
          icon: CupertinoIcons.delete, // Use the Cupertino icon
        ),
        _buildActionButton(
          onPressed: () {
            controller.setFavorite();
          },
          icon: controller.getFavorite()
              ? CupertinoIcons.heart_fill
              : CupertinoIcons.heart, // Use the Cupertino icon
        ),
      ],
    );
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

  bool getFavorite();

  void setFavorite();

  void navigateToThisItem();
}
