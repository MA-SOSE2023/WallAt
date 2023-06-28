import 'package:flutter/cupertino.dart';

import '/pages/folders/folder_item.dart';
import '/pages/folders/folder_model.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        ErrorMessage,
        NoElementsMessage,
        FutureOptionBuilder,
        SliverActivityIndicator;

class FutureSliverFolderBuilder extends StatelessWidget {
  const FutureSliverFolderBuilder({
    required Future<Folder?> future,
    required List<Widget> Function(List<FolderItem>) success,
    super.key,
  })  : _future = future,
        _onSuccessBuilder = success;

  final Future<Folder?> _future;
  final List<Widget> Function(List<FolderItem>) _onSuccessBuilder;

  final String _onNullMessage =
      'No matching folder was found.\nTry restarting the app.';
  final String _emptyListMessage =
      'This folder is empty.\nTry adding some items.';
  final String _errorMessage =
      'An error occurred while loading the folder.\nTry restarting the app.';

  @override
  Widget build(BuildContext context) {
    return FutureOptionBuilder(
      future: _future,
      success: (folder) {
        final List<FolderItem>? contents = folder?.contents;
        return CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(folder?.title ?? 'Folders'),
            ),
            if (folder == null || contents == null)
              ErrorMessage(
                message: _onNullMessage,
              )
            else if (contents.isEmpty)
              NoElementsMessage(
                message: _emptyListMessage,
              )
            else
              ..._onSuccessBuilder(folder.contents!),
          ],
        );
      },
      error: (_) => CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Folders'),
          ),
          ErrorMessage(
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
