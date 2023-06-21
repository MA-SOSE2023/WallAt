import 'home_model.dart';
import '/pages/home/home_view.dart';
import '/pages/single_item/model/item_event.dart';

List<ItemEvent> mockEvents = [
  ItemEvent(
      description:
          "Example Event with very long text that will surely overflow the screen",
      date: DateTime.now(),
      parentId: '1'),
  ItemEvent(description: "Example Event", date: DateTime.now(), parentId: '1'),
  ItemEvent(description: "Example Event", date: DateTime.now(), parentId: '1')
];

class HomeControllerMock extends HomeController {
  HomeControllerMock() : super(HomeModel(events: mockEvents, itemIds: ['1']));
}
