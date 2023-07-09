import 'package:flutter/cupertino.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/localization/language.dart';

import 'profile_model.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/services/persistence/persistence_service.dart';

class AddOrEditProfileDialog extends ConsumerStatefulWidget {
  const AddOrEditProfileDialog({
    bool isAddDialog = true,
    ProfileModel? editProfile,
    super.key,
  })  : _isAddDialog = isAddDialog,
        _editProfile = editProfile;

  final bool _isAddDialog;
  final ProfileModel? _editProfile;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddorEditProfileDialogState();
}

class _AddorEditProfileDialogState
    extends ConsumerState<AddOrEditProfileDialog> {
  String? newProfileName;
  TextEditingController? profileNameTextController;
  int newProfilePictureIndex = 0;
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    assert(widget._isAddDialog || widget._editProfile != null);
    newProfileName = widget._editProfile?.name;
    profileNameTextController = TextEditingController(text: newProfileName);
  }

  @override
  Widget build(BuildContext context) {
    List<ImageProvider> availableProfilePictures =
        PersistenceService.selectableProfilePictures;

    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;

    final Widget addDialogAction = CupertinoDialogAction(
      child: Text(language.lblAdd),
      onPressed: () {
        ref.read(Providers.profilesControllerProvider.notifier).createProfile(
            newProfileName ?? language.nameProfile, newProfilePictureIndex);
        Navigator.of(context).pop();
      },
    );

    final Widget editDialogAction = CupertinoDialogAction(
      child: Text(language.lblEdit),
      onPressed: () {
        ref.read(Providers.profilesControllerProvider.notifier).updateProfile(
              widget._editProfile!,
              newName: newProfileName,
              selectedImageIndex: newProfilePictureIndex,
            );
        Navigator.of(context).pop();
      },
    );

    return CupertinoAlertDialog(
      title: Text(
          '${widget._isAddDialog ? language.lblAdd : language.lblEdit} ${language.nameProfile}'),
      content: Column(
        children: [
          CupertinoTextField(
            controller: profileNameTextController,
            placeholder: language.txtProfileName,
            onChanged: (value) => setState(() {
              newProfileName = value;
            }),
          ),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              FlutterCarousel.builder(
                itemCount: availableProfilePictures.length,
                itemBuilder: (context, index, realIndex) =>
                    // Empty gesture detector to disable
                    // swipe gestures on the carousel
                    GestureDetector(
                  onHorizontalDragEnd: (details) => {},
                  onHorizontalDragCancel: () => {},
                  onHorizontalDragUpdate: (details) => {},
                  onHorizontalDragStart: (details) => {},
                  onHorizontalDragDown: (details) => {},
                  child: Image(
                    height: 40,
                    image: availableProfilePictures[index],
                  ),
                ),
                options: CarouselOptions(
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  showIndicator: true,
                  controller: carouselController,
                  slideIndicator: CircularWaveSlideIndicator(
                    currentIndicatorColor: theme.accentColor,
                    indicatorBackgroundColor: theme.groupingColor,
                  ),
                  viewportFraction: 0.4,
                  height: 150,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: theme.groupingColor.withOpacity(0.95),
                      shape: BoxShape.circle,
                    ),
                    child: CupertinoButton(
                      padding: const EdgeInsets.only(left: 5),
                      minSize: 30,
                      child: Icon(
                        CupertinoIcons.back,
                        color: theme.accentColor,
                        size: 30,
                      ),
                      onPressed: () {
                        carouselController.previousPage();
                        setState(() {
                          newProfilePictureIndex = newProfilePictureIndex == 0
                              ? availableProfilePictures.length - 1
                              : newProfilePictureIndex - 1;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: theme.groupingColor.withOpacity(0.95),
                      shape: BoxShape.circle,
                    ),
                    child: CupertinoButton(
                        minSize: 30,
                        padding: const EdgeInsets.only(left: 6),
                        child: Icon(
                          CupertinoIcons.forward,
                          color: theme.accentColor,
                          size: 30,
                        ),
                        onPressed: () {
                          carouselController.nextPage();
                          setState(() {
                            newProfilePictureIndex =
                                (newProfilePictureIndex + 1) %
                                    availableProfilePictures.length;
                          });
                        }),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(language.lblCancel),
          onPressed: () => Navigator.of(context).pop(),
        ),
        if (widget._isAddDialog) addDialogAction else editDialogAction,
      ],
    );
  }
}
