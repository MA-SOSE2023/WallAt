import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import 'home_model.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show EventCard, cameraButtonHeroTag;
import '/router/router.dart';
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
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
                  viewportFraction: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}

abstract class HomeController extends StateNotifier<HomeModel> {
  HomeController(HomeModel state) : super(state);

  List<ItemEvent> get events => state.events;
}
