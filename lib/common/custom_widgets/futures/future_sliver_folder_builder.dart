import 'package:flutter/cupertino.dart';

import '/pages/folders/folder_item.dart';
import '/pages/folders/folder_model.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show ErrorMessage, NoElementsMessage, FutureOptionBuilder;

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
        return CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(folder?.title ?? 'Folders'),
            ),
            if (folder == null || folder.contents == null)
              ErrorMessage(
                message: _onNullMessage,
              )
            else if (folder.contents!.isEmpty)
              NoElementsMessage(
                message: _emptyListMessage,
              )
            else
              ..._onSuccessBuilder(folder.contents!),
          ],
        );
      },
      errror: (_) => CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Folders'),
          ),
          ErrorMessage(
            message: _errorMessage,
          ),
        ],
      ),
      loading: () => CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Folders'),
          ),
          SliverSafeArea(
            minimum:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
            sliver: const SliverToBoxAdapter(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
