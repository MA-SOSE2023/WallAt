import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/theme/custom_theme_data.dart';

import '/pages/single_item/model/single_item.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show FutureOptionBuilder, DocumentCard, ActivityIndicator;

class DocumentCardContainer extends ConsumerWidget {
  const DocumentCardContainer({
    required SingleItem item,
    BoxDecoration? containerDeco,
    Color? backgroundColor,
    bool? showFavoriteButton,
    super.key,
  })  : _item = item,
        _containerDeco = containerDeco,
        _backgroundColor = backgroundColor,
        _showFavoriteButton = showFavoriteButton ?? true;

  DocumentCardContainer.borderless({
    required SingleItem item,
    Color? backgroundColor,
    bool? showFavoriteButton,
    super.key,
  })  : _item = item,
        _containerDeco = BoxDecoration(
          color: backgroundColor,
        ),
        _backgroundColor = backgroundColor,
        _showFavoriteButton = showFavoriteButton ?? true;

  final SingleItem _item;
  final BoxDecoration? _containerDeco;
  final Color? _backgroundColor;
  final bool _showFavoriteButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<SingleItem> itemFuture =
        ref.watch(Providers.singleItemControllerProvider(_item.id));
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    Widget documentCardRow(SingleItem item) => Row(
          children: [
            Expanded(child: DocumentCard(item: item)),
            if (_showFavoriteButton)
              CupertinoButton(
                onPressed: ref
                    .read(Providers.singleItemControllerProvider(item.id)
                        .notifier)
                    .setFavorite,
                child: Icon(item.isFavorite
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart),
              ),
          ],
        );

    return DecoratedBox(
      decoration: _containerDeco ??
          BoxDecoration(
            color: _backgroundColor ?? theme.backgroundColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: theme.groupingColor,
              width: 1,
            ),
          ),
      child: FutureOptionBuilder(
        future: itemFuture,
        loading: () => DocumentCard(
            item: SingleItem.placeholder(id: _item.id, image: _item.image)),
        error: (_) => DocumentCard(item: SingleItem.error()),
        success: (item) => documentCardRow(item),
      ),
    );
  }
}
