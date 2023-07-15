import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import 'home_model.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/localization/language.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        AsyncSliverListBuilder,
        DocumentCardContainerList,
        EventCard,
        ProfilesButton,
        SliverActivityIndicator,
        SliverNoElementsMessage,
        cameraButtonHeroTag;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<HomeModel> model = ref.watch(Providers.homeControllerProvider);
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 15.0),
        child: FloatingActionButton(
          backgroundColor: theme.accentColor,
          onPressed: () => ref
              .read(Providers.takePictureControllerProvider(null).notifier)
              .takePicture(ref),
          heroTag: cameraButtonHeroTag,
          child: const Icon(
            CupertinoIcons.camera,
            size: 30,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: theme.navBarColor,
            largeTitle: Text(language.titleHome),
            trailing: const ProfilesButton(),
          ),
          AsyncSliverListBuilder(
            future: model.whenData((m) => m.events),
            loading: () => const SliverActivityIndicator(
              padding: EdgeInsets.only(
                top: 60.0,
                bottom: 60.0,
              ),
            ),
            empty: (emptyMessage) => SliverNoElementsMessage(
              message: emptyMessage,
              minPadding: 50.0,
            ),
            success: (events) => SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 180),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: FlutterCarousel(
                    items:
                        events.map((event) => EventCard(event: event)).toList(),
                    options: CarouselOptions(
                      initialPage: 0,
                      enableInfiniteScroll: events.length > 1,
                      enlargeCenterPage: true,
                      showIndicator: true,
                      slideIndicator: CircularWaveSlideIndicator(
                        currentIndicatorColor: theme.accentColor,
                        indicatorBackgroundColor: theme.groupingColor,
                      ),
                      viewportFraction: 0.85,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
            emptyMessage: language.infoNoEventsYet,
            errorMessage: language.errLoadEvents,
            onNullMessage: language.errLoadEvents,
            errorMessagesPadding: 40.0,
          ),
          SliverAppBar(
            pinned: true,
            toolbarHeight: 20.0,
            backgroundColor: theme.groupingColor,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              title: Text(
                language.lblFrequentlyUsed,
                style: TextStyle(
                  fontSize: 18,
                  color: theme.textColor,
                ),
              ),
            ),
          ),
          AsyncSliverListBuilder(
            future: model.whenData((m) => m.recentItems),
            success: (recentItems) => DocumentCardContainerList(
              items: recentItems,
              showFavoriteButton: false,
            ),
            emptyMessage: language.infoNoItemsYet,
            errorMessage: language.errLoadRecentItems,
            onNullMessage: language.errLoadRecentItems,
          )
        ],
      ),
    );
  }
}

abstract class HomeController extends AutoDisposeAsyncNotifier<HomeModel> {}
