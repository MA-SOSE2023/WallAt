import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/localization/language.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        DocumentCardContainerList,
        CameraButtonHeroDestination,
        SearchBarContainer,
        FutureSliverListBuilder,
        ProfilesButton;

import '/pages/single_item/model/single_item.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  late String searchString;

  @override
  void initState() {
    super.initState();
    searchString = '';
  }

  @override
  Widget build(BuildContext context) {
    Future<List<SingleItem>> favoritesFuture = ref
        .watch(Providers.favoritesControllerProvider.notifier)
        .filterFavorites(searchString);

    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    final emptyListMessage = searchString.isEmpty
        ? language.infoFavoritesEmpty
        : '${language.infoNoItemsFoundForFilter} "$searchString".';

    return CupertinoPageScaffold(
      backgroundColor: theme.backgroundColor,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                backgroundColor: theme.navBarColor,
                largeTitle: Text(language.titleFavorites),
                trailing: const ProfilesButton(),
              ),
              SliverAppBar(
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: SearchBarContainer(
                    onChanged: (text) {
                      setState(() {
                        searchString = text;
                      });
                    },
                  ),
                ),
                toolbarHeight: 35.0,
              ),
              FutureSliverListBuilder(
                future: favoritesFuture,
                success: (favorites) => DocumentCardContainerList(
                    items: favorites, borderlessCards: true),
                emptyMessage: emptyListMessage,
                errorMessage: language.errApplyFilter,
                errorMessagesPadding: 25,
              )
            ],
          ),
          const CameraButtonHeroDestination(),
        ],
      ),
    );
  }
}

abstract class FavoritesController
    extends StateNotifier<Future<List<SingleItem>>> {
  FavoritesController(Future<List<SingleItem>> state) : super(state);

  Future<List<SingleItem>> get favorites;

  Future<List<SingleItem>> filterFavorites(String searchString);
}
