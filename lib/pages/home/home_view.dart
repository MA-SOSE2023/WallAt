import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gruppe4/common/custom_widgets/document_card.dart';

import 'home_model.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show EventCard, cameraButtonHeroTag;
import '/router/router.dart';
import '/pages/single_item/model/item_event.dart';
import '/pages/single_item/model/single_item.dart';

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
    final List<DocumentCard> documentCards =
        model.itemIds.map((id) => DocumentCard(id: id)).toList();
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0, right: 10.0),
        child: FloatingActionButton(
          foregroundColor: CupertinoTheme.of(context).primaryContrastingColor,
          backgroundColor: CupertinoTheme.of(context).primaryColor,
          onPressed: () => Routers.globalRouterDelegate.beamToNamed('/camera'),
          heroTag: cameraButtonHeroTag,
          child: const Icon(
            CupertinoIcons.camera,
            size: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FlutterCarousel(
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
                height: MediaQuery.of(context).size.height / 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CupertinoListSection.insetGrouped(
                header: Text(
                  'Frequently Used',
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                ),
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2),
                    child: ListView(
                      children: [
                        ...documentCards
                            .sublist(0, documentCards.length - 1)
                            .map(
                          (card) {
                            return Column(
                              children: [
                                card,
                                const Divider(
                                  height: 0,
                                  thickness: 1,
                                  indent: 64,
                                ),
                              ],
                            );
                          },
                        ).toList(),
                        documentCards.last,
                      ],
                    ),
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

abstract class HomeController extends StateNotifier<HomeModel> {
  HomeController(HomeModel state) : super(state);

  List<ItemEvent> get events => state.events;
  List<String> get itemIds => state.itemIds;
}
