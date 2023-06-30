import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/custom_widgets/all_custom_widgets.dart';

import '/common/custom_widgets/info_container/event_card.dart';

import '/common/custom_widgets/futures/future_option_builder.dart';
import '../home/home_model.dart';
import 'profile_model.dart';

import 'package:flutter/cupertino.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/provider.dart';

import '/pages/settings/settings_model.dart';
import '/pages/settings/settings_view.dart';

class ProfilesPage extends ConsumerWidget {
  const ProfilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfilesController controller =
        ref.read(Providers.profilesControllerProvider.notifier);
    List<ProfileModel> profiles =
        ref.watch(Providers.profilesControllerProvider);
    SettingsModel settings = ref.watch(Providers.settingsControllerProvider);
    SettingsController settingsController =
        ref.read(Providers.settingsControllerProvider.notifier);
    Future<HomeModel> model = ref.watch(Providers.homeControllerProvider);
    final Future<List<EventCard>> eventCards = model.then((m) => m.events
        .map((event) => EventCard(
              event: event,
            ))
        .toList());
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
                    child: FutureOptionBuilder(
                      future: eventCards,
                      loading: () => ActivityIndicator(),
                      error: (error) => ErrorMessage(
                          message:
                              "Something went wrong.\nPlease try again later."),
                      success: (eventCards) => FlutterCarousel(
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
                    ),
                  ))),
          SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 6.0,
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
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: theme.accentColor, width: 2),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: controller
                                            .getProfilePicture(profiles[index])!
                                            .image,
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            Text(profiles[index].name,
                                style: TextStyle(color: theme.textColor)),
                            if (index == settings.selectedProfileIndex)
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: theme.backgroundColor,
                                      ),
                                      child: Text("Currently Selected",
                                          style: TextStyle(
                                              color: theme.textColor))))
                            else
                              CupertinoButton(
                                  child: Text("Select this profile"),
                                  onPressed: () => {
                                        settingsController
                                            .setProfileIndex(index),
                                        context.beamBack(),
                                      })
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
