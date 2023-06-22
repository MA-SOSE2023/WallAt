import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'favorites_view.dart';
import '/pages/single_item/model/item_event.dart';
import '/pages/single_item/model/single_item.dart';

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

class FavoritesControllerMock extends FavoritesController {
  FavoritesControllerMock() : super(_mockItems);

  @override
  List<SingleItem> get favorites => state;
}
