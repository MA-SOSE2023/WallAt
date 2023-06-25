import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';

import '/pages/single_item/model/item_event.dart';
import '/pages/single_item/model/single_item.dart';

import 'folder_item.dart';
import 'folder_model.dart';
import 'folders_view.dart';

List<ItemEvent> _mockEvents = [
  ItemEvent(
      id: '0',
      event: Event("1",
          eventId: null,
          title: 'Example Event',
          description: 'Example Description',
          start: TZDateTime.now(local),
          end: TZDateTime.now(local)),
      parentId: "1"),
  ItemEvent(
      id: '1',
      event: Event("2",
          eventId: null,
          title: 'Example Event',
          description: 'Example Description',
          start: TZDateTime.now(local),
          end: TZDateTime.now(local)),
      parentId: "1"),
  ItemEvent(
      id: '2',
      event: Event("3",
          eventId: null,
          title: 'Example Event',
          description: 'Example Description',
          start: TZDateTime.now(local),
          end: TZDateTime.now(local)),
      parentId: "1"),
];

SingleItem _mockSingleItem(int id) => SingleItem(
      id: '$id',
      title: 'Example Title',
      description: 'Example Description',
      image: const AssetImage('assets/dev_debug_images/hampter1.jpg'),
      isFavorite: true,
      events: _mockEvents.map((e) => e.copyWith(parentId: '$id')).toList(),
      currentSelectedDate: null,
    );

var _id = 0;

List<FolderItem> _mockItems() => [
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
  title: 'Folders',
  contents: [
    Folder(id: '1', title: 'Example Folder', contents: [
      Folder(id: '4', title: 'Example Subfolder', contents: _mockItems()),
      Folder(id: '5', title: 'Another Subfolder', contents: _mockItems()),
      ..._mockItems().take(2),
    ]),
    Folder(id: '2', title: 'Another Folder', contents: _mockItems()),
    Folder(
        id: '3',
        title: 'Yet Another Folder',
        contents: _mockItems().take(7).toList()),
    ..._mockItems(),
  ],
);

Folder _mockFolderItem(String id) {
  switch (id) {
    case '0':
      return rootFolder;
    case '1':
      return rootFolder.contents[0].folder;
    case '2':
      return rootFolder.contents[1].folder;
    case '3':
      return rootFolder.contents[2].folder;
    case '4':
      return rootFolder.contents[0].contents[0].folder;
    case '5':
      return rootFolder.contents[0].contents[1].folder;
    default:
      throw UnsupportedError('Unknown id: $id');
  }
}

class FoldersControllerMock extends FoldersController {
  FoldersControllerMock(String id) : super(_mockFolderItem(id));

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
