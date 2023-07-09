import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/folders/folder_item.dart';
import '/pages/folders/folder_model.dart';
import '/common/provider.dart';
import '/common/localization/language.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        SliverErrorMessage,
        SliverNoElementsMessage,
        FutureOptionBuilder,
        SliverActivityIndicator;

class FutureSliverFolderBuilder extends ConsumerWidget {
  const FutureSliverFolderBuilder({
    required Future<Folder?> future,
    required List<Widget> Function(List<FolderItem>, Folder) success,
    super.key,
  })  : _future = future,
        _onSuccessBuilder = success;

  final Future<Folder?> _future;
  final List<Widget> Function(List<FolderItem>, Folder) _onSuccessBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;

    final String onNullMessage = language.errNullFolder;
    final String emptyListMessage = language.infoFolderEmpty;
    final String errorMessage = language.errLoadFolder;
    return FutureOptionBuilder(
      future: _future,
      success: (folder) {
        final List<FolderItem>? contents = folder.contents;
        return CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              backgroundColor: theme.navBarColor,
              largeTitle: Text(folder.title),
            ),
            if (contents == null)
              SliverErrorMessage(
                message: onNullMessage,
              )
            else if (contents.isEmpty) ...[
              ..._onSuccessBuilder(contents, folder),
              SliverNoElementsMessage(
                message: emptyListMessage,
              )
            ] else
              ..._onSuccessBuilder(contents, folder),
          ],
        );
      },
      error: (_) => CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: theme.navBarColor,
            largeTitle: Text(language.titleFolders),
          ),
          SliverErrorMessage(
            message: errorMessage,
          ),
        ],
      ),
      loading: () => CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: theme.navBarColor,
            largeTitle: Text(language.titleFolders),
          ),
          const SliverActivityIndicator(),
        ],
      ),
    );
  }
}
