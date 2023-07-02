import 'package:beamer/beamer.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_share/social_share.dart';

import 'full_screen_image_view.dart';
import 'edit_single_item_view.dart';
import 'model/single_item.dart';
import 'model/item_event.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show EventsContainer, AsyncOptionBuilder;

String singleItemHeroTag(String id) {
  return "single_item_image$id";
}

class SingleItemPage extends ConsumerWidget {
  const SingleItemPage({required SingleItem item, Key? key})
      : _item = item,
        super(key: key);

  final SingleItem _item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<SingleItem?> item =
        ref.watch(Providers.singleItemControllerProvider(_item.id));
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    return AsyncOptionBuilder(
      future: item,
      initialData: _item,
      loading: () => const Align(
          alignment: Alignment.center, child: CupertinoActivityIndicator()),
      error: (_) => const Align(
          alignment: Alignment.center,
          child: Text("Fatal error, please restart the app")),
      success: (item) => CupertinoPageScaffold(
        backgroundColor: theme.backgroundColor,
        child: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    titleSpacing: 10,
                    pinned: true,
                    stretch: true,
                    leading: CupertinoNavigationBarBackButton(
                      previousPageTitle: '',
                      onPressed: () => context.beamBack(),
                    ),
                    backgroundColor: theme.navBarColor,
                    expandedHeight: MediaQuery.of(context).size.height / 1.5,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Row(children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              item.title,
                            ),
                          ),
                        ),
                      ]),
                      background: GestureDetector(
                        child: Stack(
                          children: [
                            Hero(
                              tag: singleItemHeroTag(item.id.toString()),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: item.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 50, 50, 50),
                                    Color.fromARGB(0, 0, 0, 0),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [0.0, 0.3],
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => FullScreenImagePage(
                                itemId: item.id,
                                imageProvider: item.image,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.groupingColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _InfoContainer(
                          text: item.description,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(20.0),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                          decoration: BoxDecoration(
                            color: theme.groupingColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: EventsContainer(item: item, editable: false)),
                    ),
                  ),
                  // Empty box at the bottom to make sure you can scroll the
                  // events above the bottom bar
                  const SliverPadding(
                      padding: EdgeInsets.only(bottom: 60),
                      sliver: SliverToBoxAdapter(
                        child: SizedBox(height: 10),
                      )),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: theme.navBarColor,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: _ActionButtons(itemId: item.id),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoContainer extends StatelessWidget {
  const _InfoContainer({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
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

class _ActionButtons extends ConsumerWidget {
  const _ActionButtons({Key? key, required this.itemId}) : super(key: key);

  final int itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<SingleItem?> item =
        ref.watch(Providers.singleItemControllerProvider(itemId));
    final SingleItemController controller =
        ref.read(Providers.singleItemControllerProvider(itemId).notifier);
    return AsyncOptionBuilder(
      future: item,
      success: (item) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            onPressed: () {
              SocialShare.shareOptions(
                "Hello world",
                //@TODO: add the correct image path
              );
            },
            child: const Icon(CupertinoIcons.share),
          ),
          CupertinoButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => EditSingleItemPage(singleItem: item),
              );
            },
            child: const Icon(
                CupertinoIcons.slider_horizontal_3), // Use the Cupertino icon
          ),
          CupertinoButton(
            onPressed: () {
              controller.deleteItem();
              context.beamBack();
            },
            child: const Icon(CupertinoIcons.delete), // Use the Cupertino icon
          ),
          CupertinoButton(
            onPressed: () {
              controller.toggleFavorite();
            },
            child: Icon(item.isFavorite
                ? CupertinoIcons.heart_fill
                : CupertinoIcons.heart), // Use the Cupertino icon
          ),
        ],
      ),
    );
  }
}

abstract class SingleItemController
    extends AutoDisposeFamilyAsyncNotifier<SingleItem?, int>
    implements SingleItemControllerInterface {}

abstract class SingleItemControllerInterface {
  void setImage(ImageProvider image);

  void setDescription(String description);

  void setTitle(String title);

  void addEvent({required Event event, required int parentId});

  void removeEvent(ItemEvent event);

  void deleteItem();

  void toggleFavorite();

  void navigateToThisItem();
}
