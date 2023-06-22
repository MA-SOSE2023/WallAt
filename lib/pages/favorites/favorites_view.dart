import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        DocumentCardContainerList,
        CameraButtonHeroDestination,
        SearchBarContainer;
import '/pages/single_item/model/single_item.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<SingleItem> favorites =
        ref.watch(Providers.favoritesControllerProvider);
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
                children: [
                  DocumentCardContainerList(items: favorites),
                  // Search bar for filtering items
                  SearchBarContainer(onChanged: (value) {}),
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
