import 'package:flutter/cupertino.dart';

import '/common/custom_widgets/all_custom_widgets.dart'
    show DocumentCardContainerList, CameraButtonHeroDestination;

class FavoritesScren extends StatelessWidget {
  const FavoritesScren({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> itemIds = <String>[
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8'
    ];
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                    child: SizedBox(
                      height: 50,
                      child: CupertinoTextField(
                        placeholder: 'Search',
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: CupertinoTheme.of(context)
                              .scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: CupertinoDynamicColor.resolve(
                                CupertinoColors.label, context),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
