import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        DocumentCardContainerList,
        CameraButtonHeroDestination,
        SearchBarContainer,
        FutureSliverListBuilder;
import '/pages/single_item/model/single_item.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({bool borderlessCards = true, super.key})
      : _borderlessCards = borderlessCards;

  final bool _borderlessCards;

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

    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    final emptyListMessage = searchString.isEmpty
        ? 'No favorites yet.\nTry adding some by tapping the heart icon.'
        : 'No items found for "$searchString".';

    return CupertinoPageScaffold(
      backgroundColor: theme.backgroundColor,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                backgroundColor: theme.navBarColor,
                largeTitle: const Text('Favorites'),
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
                    items: favorites, borderlessCards: widget._borderlessCards),
                emptyMessage: emptyListMessage,
                errorMessage: 'Filter could not be applied',
                onNullMessage:
                    'Something went wrong while loading your favorites.\nTry restarting the app.',
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
