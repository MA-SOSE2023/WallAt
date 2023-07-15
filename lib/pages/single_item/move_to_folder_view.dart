import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/single_item.dart';

import '/pages/folders/folder_model.dart';
import '/common/provider.dart';
import '/common/localization/language.dart';
import '/common/theme/custom_theme_data.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show LoadingOptionBuilder;

class MoveToFolderScreen extends ConsumerWidget {
  const MoveToFolderScreen(
      {required SingleItem item, Folder? folder, super.key})
      : _item = item,
        _folder = folder;

  final SingleItem _item;
  final Folder? _folder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;

    final Folder folder =
        ref.watch(Providers.foldersControllerProvider(_folder?.id));

    return CupertinoPageScaffold(
      backgroundColor: theme.backgroundColor,
      child: LoadingOptionBuilder(
        resource: folder,
        initialData: _folder,
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
                  child: Text(language.lblCancel,
                      style: const TextStyle(fontSize: 15)),
                  onPressed: () {
                    // Cancel the item
                    ref
                        .read(Providers.singleItemControllerProvider(_item.id)
                            .notifier)
                        .deleteItem();
                    context.beamBack(data: null);
                  },
                ),
                trailing: CupertinoButton(
                  padding: const EdgeInsets.all(10),
                  child: Text(language.lblSave,
                      style: const TextStyle(fontSize: 15)),
                  onPressed: () {
                    // get controller for root folder in which we placed the
                    // item preemtively, and move it to the selected folder
                    ref
                        .read(
                            Providers.foldersControllerProvider(null).notifier)
                        .moveItem(_item, folder);
                    context.beamBack();
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
                        folder: subFolder[index],
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
