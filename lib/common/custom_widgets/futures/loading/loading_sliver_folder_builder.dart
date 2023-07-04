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
        LoadingOptionBuilder,
        SliverActivityIndicator,
        ProfilesButton;

class LoadingSliverFolderBuilder extends ConsumerWidget {
  const LoadingSliverFolderBuilder({
    required Folder folder,
    required List<Widget> Function(List<FolderItem> contents, Folder folder)
        success,
    Folder? initialData,
    super.key,
  })  : _folder = folder,
        _onSuccessBuilder = success,
        _initialData = initialData;

  final Folder _folder;
  final List<Widget> Function(List<FolderItem> contents, Folder folder)
      _onSuccessBuilder;
  final Folder? _initialData;

  final String _onNullMessage =
      'No matching folder was found.\nTry restarting the app.';
  final String _emptyListMessage =
      'This folder is empty.\nTry adding some items.';
  final String _errorMessage =
      'An error occurred while loading the folder.\nTry restarting the app.';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    Widget folderScrollView({
      required List<Widget> children,
      String? title,
    }) {
      return CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: theme.navBarColor,
            largeTitle: Text(title ?? ''),
            trailing: const ProfilesButton(),
          ),
          ...children,
        ],
      );
    }

    return LoadingOptionBuilder(
      resource: _folder,
      initialData: _initialData,
      onNull: () => folderScrollView(
        title: 'Folders',
        children: [
          SliverErrorMessage(
            message: _onNullMessage,
          ),
        ],
      ),
      success: (folder) {
        final List<FolderItem>? contents = folder.contents;
        return folderScrollView(
          title: folder.title,
          children: [
            if (contents == null)
              SliverErrorMessage(
                message: _onNullMessage,
              )
            else if (contents.isEmpty) ...[
              ..._onSuccessBuilder(contents, folder),
              SliverNoElementsMessage(
                message: _emptyListMessage,
              )
            ] else
              ..._onSuccessBuilder(contents, folder),
          ],
        );
      },
      error: () => folderScrollView(
        title: 'Folders',
        children: [
          SliverErrorMessage(
            message: _errorMessage,
          ),
        ],
      ),
      loading: () => folderScrollView(
        children: [
          const SliverActivityIndicator(),
        ],
      ),
    );
  }
}
