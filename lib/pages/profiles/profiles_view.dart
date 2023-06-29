import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/custom_widgets/event_card.dart';
import '../home/home_model.dart';
import 'profile_model.dart';

import 'package:flutter/cupertino.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/provider.dart';

class ProfilesPage extends ConsumerWidget {
  const ProfilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfilesController controller =
        ref.read(Providers.profilesControllerProvider.notifier);
    List<ProfileModel> profiles =
        ref.watch(Providers.profilesControllerProvider);
    HomeModel model = ref.watch(Providers.homeControllerProvider);
    final List<EventCard> eventCards = model.events
        .map((event) => EventCard(
              event: event,
            ))
        .toList();
    CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: CustomScrollView(slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: theme.navBarColor,
            largeTitle: Text('Profiles'),
          ),
          SliverToBoxAdapter(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 4),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: FlutterCarousel(
                      items: eventCards,
                      options: CarouselOptions(
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        showIndicator: true,
                        slideIndicator: CircularWaveSlideIndicator(
                            currentIndicatorColor: theme.accentColor,
                            indicatorBackgroundColor: theme.groupingColor),
                        viewportFraction: 0.85,
                        height: double.infinity,
                      ),
                    ),
                  ))),
          SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: theme.groupingColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: theme.accentColor, width: 2),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: controller
                                                .getProfilePicture(
                                                    profiles[index])
                                                ?.image ??
                                            AssetImage(
                                                'assets/images/placeholder.png'),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            Text(profiles[index].name,
                                style: TextStyle(color: theme.textColor)),
                            Text("Currently active")
                          ]),
                        ),
                      ),
                  childCount: profiles.length))
        ]));
  }
}

abstract class ProfilesController extends StateNotifier<List<ProfileModel>> {
  ProfilesController(List<ProfileModel> state) : super(state);

  void setCurrentProfile(ProfileModel profile) {}

  Image? getProfilePicture(ProfileModel profile) {}
}
