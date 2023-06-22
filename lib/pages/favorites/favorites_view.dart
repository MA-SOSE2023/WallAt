import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        DocumentCardContainerList,
        CameraButtonHeroDestination,
        SearchBarContainer,
        NoElementsMessage,
        ErrorMessage;
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
    AsyncValue<List<SingleItem>> favoritesFuture =
        ref.watch(Providers.favoritesControllerProvider);

    final emptyListMessage = searchString.isEmpty
        ? 'No favorites yet.\nTry adding some by tapping the heart icon.'
        : 'No items found for "$searchString".';

    final AsyncValue<List<SingleItem>> filterFavoritesFuture =
        favoritesFuture.whenData(
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

    final Widget body = filterFavoritesFuture.when(
      error: (object, stackTrace) => favoritesFuture.hasError
          ? const ErrorMessage()
          : const ErrorMessage(message: 'Filter could not be applied'),
      loading: () => const CupertinoActivityIndicator(),
      data: (filteredFavorites) => filteredFavorites.isNotEmpty
          ? DocumentCardContainerList(items: filteredFavorites)
          : Expanded(child: NoElementsMessage(message: emptyListMessage)),
    );

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Favorites'),
      ),
      child: Stack(
        children: [
          const CameraButtonHeroDestination(),
          SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  filterFavoritesFuture.hasValue ? body : Expanded(child: body),
                  // Search bar for filtering items
                  SearchBarContainer(onChanged: (text) {
                    setState(() {
                      searchString = text;
                    });
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

abstract class FavoritesController extends StateNotifier<List<SingleItem>> {
  FavoritesController(List<SingleItem> state) : super(state);

  List<SingleItem> get favorites;
}
