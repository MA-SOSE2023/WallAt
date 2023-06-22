import 'home_model.dart';
import 'home_view.dart';
import '/pages/single_item/model/single_item.dart';
import '/pages/single_item/model/item_event.dart';

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

class HomeControllerMock extends HomeController {
  HomeControllerMock()
      : super(HomeModel(events: _mockEvents, recentItems: _mockItems));
}
