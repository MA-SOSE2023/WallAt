import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
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
    Future<List<SingleItem>> favoritesFuture =
        ref.watch(Providers.favoritesControllerProvider);

    final emptyListMessage = searchString.isEmpty
        ? 'No favorites yet.\nTry adding some by tapping the heart icon.'
        : 'No items found for "$searchString".';

    final Future<List<SingleItem>> filterFavoritesFuture = favoritesFuture.then(
      (favorites) {
        if (searchString.isEmpty) {
          return favorites;
        } else {
          return favorites
              .where((item) =>
                  item.title.toLowerCase().contains(searchString.toLowerCase()))
              .toList();
        }
      },
    );

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const CupertinoSliverNavigationBar(
                largeTitle: Text('Favorites'),
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
                future: filterFavoritesFuture,
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
}
