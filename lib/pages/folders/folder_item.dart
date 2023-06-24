import 'folder_model.dart';
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
