import '../single_item/model/item_event.dart';
import '../single_item/model/single_item.dart';

import 'folder_model.dart';
import 'folders_view.dart';

List<ItemEvent> _mockEvents = [
  ItemEvent(
      description:
          "Example Event with very long text that will surely overflow the screen",
      date: DateTime.now(),
      parentId: '1'),
  ItemEvent(description: "Example Event", date: DateTime.now(), parentId: '1'),
  ItemEvent(description: "Example Event", date: DateTime.now(), parentId: '1')
];

SingleItem _mockSingleItem(int id) => SingleItem(
      id: '$id',
      title: 'Example Title',
      description: 'Example Description',
      image: 'assets/dev_debug_images/hampter1.jpg',
      isFavorite: true,
      events: [
        ItemEvent(
            description: "Example Event",
            date: DateTime.now(),
            parentId: '$id'),
        ItemEvent(
            description: "Example Event",
            date: DateTime.now(),
            parentId: '$id'),
        ItemEvent(
            description: "Example Event",
            date: DateTime.now(),
            parentId: '$id'),
      ],
      currentSelectedDate: null,
    );

var _id = 0;

List<SingleItem> _mockItems = [
  _mockSingleItem(_id++),
  _mockSingleItem(_id++).copyWith(title: 'Another Title'),
  _mockSingleItem(_id++).copyWith(title: 'Yet Another Title'),
  _mockSingleItem(_id++).copyWith(title: 'One More Title'),
  _mockSingleItem(_id++).copyWith(title: 'Last Title'),
  _mockSingleItem(_id++).copyWith(title: 'Last Last Title'),
  _mockSingleItem(_id++).copyWith(title: 'Last One For Sure'),
  _mockSingleItem(_id++).copyWith(title: 'Promise, this is the last'),
  _mockSingleItem(_id++).copyWith(title: 'Sorry, one more'),
];

final Folder rootFolder = Folder(
  id: '0',
  title: 'Root',
  contents: [
    Folder(id: '1', title: 'Example Folder', contents: [
      Folder(id: '4', title: 'Example Subfolder', contents: _mockItems),
      Folder(id: '5', title: 'Another Subfolder', contents: _mockItems),
      ..._mockItems,
    ]),
    Folder(id: '2', title: 'Another Folder', contents: _mockItems),
    Folder(id: '3', title: 'Yet Another Folder', contents: _mockItems),
    ..._mockItems,
  ],
);

class FoldersControllerMock extends FoldersControler {
  FoldersControllerMock(String id) : super(rootFolder.copyWith(id: id));

  @override
  List<FolderItem> get contents => state.contents;

  @override
  String get id => state.id;

  @override
  String get title => state.title;

  @override
  void addItem(FolderItem item) {
    // TODO: implement addItem
  }

  @override
  void delete() {
    // TODO: implement delete
  }

  @override
  void move(Folder newParent) {
    // TODO: implement move
  }

  @override
  void moveItem(FolderItem item, Folder newParent) {
    // TODO: implement moveItem
  }

  @override
  void removeItem(FolderItem item) {
    // TODO: implement removeItem
  }

  @override
  void rename(String newName) {
    // TODO: implement rename
  }
}
