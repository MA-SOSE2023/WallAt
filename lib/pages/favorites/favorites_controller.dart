import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';

import 'favorites_view.dart';
import '/pages/single_item/model/item_event.dart';
import '/pages/single_item/model/single_item.dart';

List<ItemEvent> _mockEvents = [
  ItemEvent(
    id: 0,
    event: Event("1",
        eventId: null,
        title: 'Example Event',
        description: 'Example Description',
        start: TZDateTime.now(local),
        end: TZDateTime.now(local)),
    parentId: 1,
  ),
  ItemEvent(
    id: 1,
    event: Event("2",
        eventId: null,
        title: 'Example Event',
        description: 'Example Description',
        start: TZDateTime.now(local),
        end: TZDateTime.now(local)),
    parentId: 1,
  ),
  ItemEvent(
    id: 2,
    event: Event("3",
        eventId: null,
        title: 'Example Event',
        description: 'Example Description',
        start: TZDateTime.now(local),
        end: TZDateTime.now(local)),
    parentId: 1,
  ),
];

SingleItem _mockSingleItem(int id) => SingleItem(
      id: id,
      title: 'Example Title',
      description: 'Example Description',
      image: const AssetImage('assets/dev_debug_images/hampter1.jpg'),
      isFavorite: true,
      events: _mockEvents.map((e) => e.copyWith(parentId: id)).toList(),
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
