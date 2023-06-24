import 'folder_model.dart';
import '/pages/single_item/model/item_event.dart';
import '/pages/single_item/model/single_item.dart';

abstract class FolderItem {
  FolderItem({
    required bool isLeaf,
    Folder? folder,
    SingleItem? item,
  })  : _folder = folder,
        _item = item,
        _isLeaf = isLeaf {
    if (isLeaf) {
      assert(item != null);
    } else {
      assert(folder != null);
    }
  }

  FolderItem.folder({
    required Folder folder,
  }) : this(
          isLeaf: false,
          folder: folder,
        );

  FolderItem.item(
    SingleItem item,
  ) : this(
          isLeaf: true,
          item: item,
        );

  FolderItem.folderFromValues({
    required String id,
    required String title,
    required List<FolderItem> contents,
  }) : this(
          isLeaf: false,
          folder: Folder(
            id: id,
            title: title,
            contents: contents,
          ),
        );

  FolderItem.itemFromValues({
    required String id,
    required String title,
    required String description,
    required String image,
    required bool isFavorite,
    required List<ItemEvent> events,
    DateTime? currentSelectedDate,
  }) : this(
          isLeaf: true,
          item: SingleItem(
            id: id,
            title: title,
            description: description,
            image: image,
            isFavorite: isFavorite,
            events: events,
            currentSelectedDate: currentSelectedDate,
          ),
        );

  final bool _isLeaf;
  final SingleItem? _item;
  final Folder? _folder;

  SingleItem? get maybeItem => _item;
  Folder? get maybeFolder => _folder;
  SingleItem get item => _item!;
  Folder get folder => _folder!;

  bool get isLeaf => _isLeaf;
  bool get isFolder => !_isLeaf;

  String get id => maybeItem?.id ?? maybeFolder!.id;
  String get title => maybeItem?.title ?? maybeFolder!.title;

  List<FolderItem> get contents => maybeFolder!.contents;
}
