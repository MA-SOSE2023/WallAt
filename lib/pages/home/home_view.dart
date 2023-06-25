import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import 'home_model.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show EventCard, DocumentCardContainerList, cameraButtonHeroTag;
import '/router/router.dart';
import '/pages/single_item/model/single_item.dart';
import '/pages/single_item/model/item_event.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeModel model = ref.watch(Providers.homeControllerProvider);
    final List<EventCard> eventCards = model.events
        .map((event) => EventCard(
              event: event,
            ))
        .toList();
    final List<SingleItem> documentCards = model.recentItems;
    return Scaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 15.0),
        child: FloatingActionButton(
          foregroundColor: CupertinoTheme.of(context).primaryContrastingColor,
          backgroundColor: CupertinoTheme.of(context).primaryColor,
          onPressed: () => ref
              .read(Providers.takePictureControllerProvider.notifier)
              .takePicture(),
          heroTag: cameraButtonHeroTag,
          child: const Icon(
            CupertinoIcons.camera,
            size: 30,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Home'),
          ),
          SliverToBoxAdapter(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 4),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: FlutterCarousel(
                  items: eventCards,
                  options: CarouselOptions(
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    showIndicator: true,
                    slideIndicator: CircularWaveSlideIndicator(
                      currentIndicatorColor: CupertinoDynamicColor.resolve(
                          CupertinoColors.activeBlue, context),
                      indicatorBackgroundColor: CupertinoDynamicColor.resolve(
                          CupertinoColors.systemGrey3, context),
                    ),
                    viewportFraction: 0.85,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ),
          SliverAppBar(
            pinned: true,
            toolbarHeight: 30.0,
            backgroundColor: CupertinoDynamicColor.resolve(
                CupertinoColors.systemGrey6, context),
            flexibleSpace: const FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 20.0, bottom: 10.0),
              title: Text(
                'Frequently Used',
                style: TextStyle(
                  fontSize: 18,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
          ),
          DocumentCardContainerList(
            items: documentCards,
            showFavoriteButton: false,
          ),
        ],
      ),
    );
  }
}

abstract class HomeController extends StateNotifier<HomeModel> {
  HomeController(HomeModel state) : super(state);

  List<ItemEvent> get events => state.events;
  List<SingleItem> get recentItems => state.recentItems;
}
