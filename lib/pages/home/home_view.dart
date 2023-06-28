import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import 'home_model.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        EventCard,
        DocumentCardContainerList,
        FutureSliverListBuilder,
        cameraButtonHeroTag;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<HomeModel> model = ref.watch(Providers.homeControllerProvider);

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
          FutureSliverListBuilder(
            future: model.then((m) => m.events),
            success: (events) => SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 4),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: FlutterCarousel(
                    items:
                        events.map((event) => EventCard(event: event)).toList(),
                    options: CarouselOptions(
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      showIndicator: true,
                      slideIndicator: CircularWaveSlideIndicator(
                        currentIndicatorColor:
                            CupertinoColors.activeBlue.resolveFrom(context),
                        indicatorBackgroundColor:
                            CupertinoColors.systemGrey3.resolveFrom(context),
                      ),
                      viewportFraction: 0.85,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
            emptyMessage:
                'Events that are nearly due will be displayed here.\nTry adding some from the edit page of an item.',
            errorMessage: 'An error occurred while loading events.\n'
                'Try restarting the app.',
            onNullMessage: 'Something went wrong while loading events.\n'
                'Try restarting the app.',
            errorMessagesPadding: 40.0,
          ),
          SliverAppBar(
            pinned: true,
            toolbarHeight: 30.0,
            backgroundColor: CupertinoColors.systemGrey6.resolveFrom(context),
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
          FutureSliverListBuilder(
            future: model.then((m) => m.recentItems),
            success: (recentItems) => DocumentCardContainerList(
              items: recentItems,
              showFavoriteButton: false,
            ),
            emptyMessage:
                'No items yet.\nTry adding some by clicking the camera button.',
            errorMessage:
                'Something went wrong while loading your recent items.\nTry restarting the app.',
            onNullMessage:
                'Something went wrong while loading your recent items.\nTry restarting the app.',
          )
        ],
      ),
    );
  }
}

abstract class HomeController extends StateNotifier<Future<HomeModel>> {
  HomeController(Future<HomeModel> state) : super(state);
}
