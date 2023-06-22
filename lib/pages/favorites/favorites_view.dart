import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        DocumentCardContainerList,
        CameraButtonHeroDestination,
        SearchBarContainer;

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> itemIds =
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
                  DocumentCardContainerList(itemIds: itemIds),
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

abstract class FavoritesController extends StateNotifier<List<String>> {
  FavoritesController(List<String> state) : super(state);

  List<String> get favorites;
}
