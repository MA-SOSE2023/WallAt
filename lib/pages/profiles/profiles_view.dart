import 'package:flutter/cupertino.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_or_edit_profile_dialog.dart';
import 'profile_container.dart';
import 'profile_model.dart';

import '/pages/single_item/model/item_event.dart';
import '/pages/settings/settings_model.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/provider.dart';
import '/common/localization/language.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        EventCard,
        FutureSliverListBuilder,
        FutureOptionBuilder,
        SliverNoElementsMessage;

class ProfilesPage extends ConsumerWidget {
  const ProfilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ProfileModel> profiles =
        ref.watch(Providers.profilesControllerProvider);
    final SettingsModel settings =
        ref.watch(Providers.settingsControllerProvider);

    Future<ProfileModel?> defaultProfile =
        ref.read(Providers.persistenceServiceProvider).getDefaultProfile();

    Future<List<ItemEvent>> events =
        ref.read(Providers.persistenceServiceProvider).getGlobalSoonEvents();

    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: theme.navBarColor,
            largeTitle: Text(language.titleProfile),
          ),
          FutureSliverListBuilder(
            future: events,
            success: (events) => SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 180),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: FlutterCarousel(
                    items:
                        events.map((event) => EventCard(event: event)).toList(),
                    options: CarouselOptions(
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
            errorMessagesPadding: 60.0,
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 10.0),
            sliver: SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              primary: false,
              toolbarHeight: 30.0,
              backgroundColor: theme.groupingColor,
              title: Text(language.titleProfile,
                  style: TextStyle(fontSize: 16, color: theme.textColor)),
              centerTitle: true,
              actions: [
                CupertinoButton(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    CupertinoIcons.plus,
                    color: theme.accentColor,
                  ),
                  onPressed: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return const AddOrEditProfileDialog();
                        });
                  },
                ),
              ],
            ),
          ),
          // Display a special button to change to the default profile
          // Allowing the user to see all items globally
          SliverToBoxAdapter(
            child: FutureOptionBuilder(
              future: defaultProfile,
              success: (defaultProfile) => Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 10.0),
                child: CupertinoButton(
                  padding: const EdgeInsets.all(0.0),
                  minSize: 32,
                  color: theme.groupingColor,
                  child: settings.selectedProfileId == defaultProfile.id
                      ? Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: theme.backgroundColor,
                          ),
                          child: Text(
                            language.lblGlobalProfileIsSelected,
                            style: TextStyle(color: theme.textColor),
                          ),
                        )
                      : Text(
                          language.btnGlobalProfile,
                          style: TextStyle(
                            color: theme.accentColor,
                          ),
                        ),
                  onPressed: () {
                    ref
                        .read(Providers.settingsControllerProvider.notifier)
                        .setProfileId(defaultProfile.id);
                    context.beamBack();
                  },
                ),
              ),
            ),
          ),
          if (profiles.isEmpty)
            SliverNoElementsMessage(
              message: language.infoNoProfiles,
              minPadding: 50.0,
            )
          else
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 6.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final ProfileModel profile = profiles[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProfileContainer(profile: profile),
                  );
                },
                childCount: profiles.length,
              ),
            )
        ],
      ),
    );
  }
}

abstract class ProfilesController extends StateNotifier<List<ProfileModel>> {
  ProfilesController(List<ProfileModel> state) : super(state);

  void createProfile(String name, int selectedImageIndex);
  void updateProfile(ProfileModel profile,
      {String? newName, int? selectedImageIndex});
  void deleteProfile(ProfileModel profile);
  Widget getProfilePicture(ProfileModel profile, {double size});
  ProfileModel getSelectedProfile();
}
