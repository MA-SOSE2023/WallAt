import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'folder_model.dart';
import 'folder_item.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show CameraButtonHeroDestination;

class FoldersScren extends StatelessWidget {
  const FoldersScren({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const CupertinoSliverNavigationBar(
                largeTitle: Text('Folders'),
              ),
              // SliverGrid to display root level folders
              SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index < 10) {
                    return Container(
                      color: CupertinoTheme.of(context).primaryColor,
                      child: const Text('Folder'),
                    );
                  } else {
                    return null;
                  }
                },
              ),
              SliverPrototypeExtentList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (index < 10) {
                        return Container(
                          color: CupertinoTheme.of(context).primaryColor,
                          child: const Text('Folder'),
                        );
                      } else {
                        return null;
                      }
                    },
                  ),
                  prototypeItem: Container(
                    color: CupertinoTheme.of(context).primaryColor,
                    child: const Text('Folder'),
                  ))
            ],
          ),
          const CameraButtonHeroDestination(),
        ],
      ),
    );
  }
}

abstract class FoldersControler extends StateNotifier<Folder> {
  FoldersControler(Folder state) : super(state);

  void delete();

  void rename(String newName);

  void move(Folder newParent);

  void addItem(FolderItem item);

  void removeItem(FolderItem item);

  void moveItem(FolderItem item, Folder newParent);

  List<FolderItem> get contents;
  String get title;
  String get id;
}
