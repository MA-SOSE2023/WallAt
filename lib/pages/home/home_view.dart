import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import 'home_model.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show EventCard, DocumentCard, cameraButtonHeroTag;
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
    final List<DocumentCard> documentCards =
        model.recentItems.map((item) => DocumentCard(item: item)).toList();
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
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
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 5),
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
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height / 5) -
                    140,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(25)),
                    color: CupertinoDynamicColor.resolve(
                        CupertinoColors.systemGroupedBackground, context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, top: 20.0, bottom: 5.0),
                        child: Text(
                          'Frequently Used',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: CupertinoTheme.of(context)
                                .scaffoldBackgroundColor,
                          ),
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
                      ),
                    ],
                  ),
                ),
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
  List<SingleItem> get recentItems => state.recentItems;
}
