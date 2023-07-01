import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/theme/custom_theme_data.dart';

import '/pages/folders/folder_item.dart';
import '/pages/folders/folder_model.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        SliverErrorMessage,
        SliverNoElementsMessage,
        AsyncOptionBuilder,
        SliverActivityIndicator;

class AsyncSliverFolderBuilder extends ConsumerWidget {
  const AsyncSliverFolderBuilder({
    required AsyncValue<Folder?> future,
    required List<Widget> Function(List<FolderItem>, Folder) success,
    super.key,
  })  : _future = future,
        _onSuccessBuilder = success;

  final AsyncValue<Folder?> _future;
  final List<Widget> Function(List<FolderItem>, Folder) _onSuccessBuilder;

  final String _onNullMessage =
      'No matching folder was found.\nTry restarting the app.';
  final String _emptyListMessage =
      'This folder is empty.\nTry adding some items.';
  final String _errorMessage =
      'An error occurred while loading the folder.\nTry restarting the app.';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    return AsyncOptionBuilder(
      future: _future,
      success: (folder) {
        final List<FolderItem>? contents = folder?.contents;
        return CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              backgroundColor: theme.navBarColor,
              largeTitle: Text(folder?.title ?? 'Folders'),
            ),
            if (folder == null || contents == null)
              SliverErrorMessage(
                message: _onNullMessage,
              )
            else if (contents.isEmpty)
              SliverNoElementsMessage(
                message: _emptyListMessage,
              )
            else
              ..._onSuccessBuilder(folder.contents!, folder),
          ],
        );
      },
      error: (_) => CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Folders'),
          ),
          SliverErrorMessage(
            message: _errorMessage,
          ),
        ],
      ),
      loading: () => const CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Folders'),
          ),
          SliverActivityIndicator(),
        ],
      ),
    );
  }
}
