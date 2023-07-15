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
        AsyncOptionBuilder,
        SliverActivityIndicator,
        ProfilesButton;

class AsyncSliverFolderBuilder extends ConsumerWidget {
  const AsyncSliverFolderBuilder({
    required AsyncValue<Folder?> future,
    required List<Widget> Function(List<FolderItem>, Folder) success,
    Folder? initialData,
    super.key,
  })  : _future = future,
        _onSuccessBuilder = success,
        _initialData = initialData;

  final AsyncValue<Folder?> _future;
  final List<Widget> Function(List<FolderItem>, Folder) _onSuccessBuilder;
  final Folder? _initialData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;

    final String onNullMessage = language.errNullFolder;
    final String emptyListMessage = language.infoFolderEmpty;
    final String errorMessage = language.errLoadFolder;
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

    return AsyncOptionBuilder(
      future: _future,
      initialData: _initialData,
      onNull: () => folderScrollView(
        title: 'Folders',
        children: [
          SliverErrorMessage(
            message: onNullMessage,
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
      error: (_) => folderScrollView(
        title: 'Folders',
        children: [
          SliverErrorMessage(
            message: errorMessage,
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
