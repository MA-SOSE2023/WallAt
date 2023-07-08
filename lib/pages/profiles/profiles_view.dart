import 'package:flutter/cupertino.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_or_edit_profile_dialog.dart';
import 'profile_container.dart';
import 'profile_model.dart';

import '/pages/home/home_model.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        AsyncSliverListBuilder,
        EventCard,
        SliverActivityIndicator,
        SliverNoElementsMessage;

class ProfilesPage extends ConsumerWidget {
  const ProfilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfilesController profilesController =
        ref.read(Providers.profilesControllerProvider.notifier);
    List<ProfileModel> profiles =
        ref.watch(Providers.profilesControllerProvider);

    AsyncValue<HomeModel> homeModel =
        ref.watch(Providers.homeControllerProvider);

    CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    // TODO: add more info for default profile. maybe change name to 'Global'
    // and place it somewhere else

    // TODO: make sure that on first app start, the default profile is not
    // only created but also selected

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: theme.navBarColor,
            largeTitle: const Text('Profiles'),
          ),
          AsyncSliverListBuilder(
            future: homeModel.whenData((m) => m.events),
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
            emptyMessage:
                'Events that are nearly due will be displayed here.\nTry adding some from the edit page of an item.',
            errorMessage: 'An error occurred while loading events.\n'
                'Try restarting the app.',
            onNullMessage: 'Something went wrong while loading events.\n'
                'Try restarting the app.',
            errorMessagesPadding: 40.0,
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 10.0),
            sliver: SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              primary: false,
              toolbarHeight: 30.0,
              backgroundColor: theme.groupingColor,
              title: Text('Profiles',
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
          if (profiles.isEmpty)
            const SliverNoElementsMessage(
              message:
                  'Profiles are a way to categorize your data in a broad way.\nEach profile will have different data.\n\nTry creating one by tapping the  +  above',
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
                    // Context menu to delete or edit profile
                    // Accessed by long pressing on a profile
                    // Should not be available for the default profile
                    child: profile.selectedImageIndex < 0
                        ? ProfileContainer(profile: profile)
                        : CupertinoContextMenu(
                            actions: [
                              CupertinoContextMenuAction(
                                trailingIcon: CupertinoIcons.pencil,
                                onPressed: () {
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return AddOrEditProfileDialog(
                                          isAddDialog: false,
                                          editProfile: profile,
                                        );
                                      });
                                },
                                child: const Text('Edit'),
                              ),
                              CupertinoContextMenuAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  profilesController.deleteProfile(profile);
                                  context.beamBack();
                                },
                                trailingIcon: CupertinoIcons.trash,
                                child: const Text('Delete'),
                              ),
                            ],
                            child: ProfileContainer(profile: profile),
                          ),
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
  Image? getProfilePicture(ProfileModel profile);
  ProfileModel getSelectedProfile();
}
