import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/single_item.dart';

import '/pages/folders/folder_model.dart';
import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show AsyncOptionBuilder, SliverActivityIndicator, ErrorMessage;

class MoveToFolderScreen extends ConsumerWidget {
  const MoveToFolderScreen({required SingleItem item, int? folderId, super.key})
      : _item = item,
        _folderId = folderId;

  final SingleItem _item;
  final int? _folderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Folder?> folder =
        ref.watch(Providers.foldersControllerProvider(_folderId));

    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

    return CupertinoPageScaffold(
      backgroundColor: theme.backgroundColor,
      child: AsyncOptionBuilder(
        future: folder,
        loading: () => const CustomScrollView(
          slivers: [SliverActivityIndicator()],
        ),
        error: (_) => const CustomScrollView(
          slivers: [
            ErrorMessage(message: "Something went wrong.\nPlease try again.")
          ],
        ),
        success: (folder) {
          final List<Folder> subFolder = (folder.contents ?? [])
              .where((item) => item.isFolder)
              .map((e) => e as Folder)
              .toList();
          return CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text(folder.title),
                backgroundColor: theme.navBarColor,
                leading: CupertinoButton(
                  padding: const EdgeInsets.all(10),
                  child: const Text('Cancel', style: TextStyle(fontSize: 15)),
                  onPressed: () {
                    // Cancel the item
                    ref
                        .read(Providers.singleItemControllerProvider(_item.id)
                            .notifier)
                        .deleteItem(ref);
                    Navigator.of(context).pop();
                  },
                ),
                trailing: CupertinoButton(
                  padding: const EdgeInsets.all(10),
                  child: const Text('Save', style: TextStyle(fontSize: 15)),
                  onPressed: () {
                    // Save the item
                    ref
                        .read(Providers.foldersControllerProvider(folder.id)
                            .notifier)
                        .moveItem(_item, folder);
                    context.beamToNamed('/item', data: _item);
                  },
                ),
              ),
              SliverGrid.builder(
                itemCount: subFolder.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MoveToFolderScreen(
                        item: _item,
                        folderId: subFolder[index].id,
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.groupingColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(3),
                    child: Column(
                      children: [
                        Expanded(
                          child: Icon(
                            CupertinoIcons.folder,
                            size: MediaQuery.of(context).size.width / 2 - 60,
                          ),
                        ),
                        Text(subFolder[index].title),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
