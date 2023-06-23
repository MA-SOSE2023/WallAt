import 'package:device_calendar/device_calendar.dart';

import 'home_model.dart';
import '/pages/home/home_view.dart';
import '/pages/single_item/model/item_event.dart';

List<ItemEvent> mockEvents = [
  // ItemEvent(
  //     event: Event("1",
  //         eventId: null,
  //         title: 'Example Event',
  //         description: 'Example Description',
  //         start: TZDateTime.now(local),
  //         end: TZDateTime.now(local)),
  //     parentId: "1"),
  // ItemEvent(
  //     event: Event("1",
  //         eventId: null,
  //         title: 'Example Event',
  //         description: 'Example Description',
  //         start: TZDateTime.now(local),
  //         end: TZDateTime.now(local)),
  //     parentId: "1"),
  // ItemEvent(
  //     event: Event("1",
  //         eventId: null,
  //         title: 'Example Event',
  //         description: 'Example Description',
  //         start: TZDateTime.now(local),
  //         end: TZDateTime.now(local)),
  //     parentId: "1"),
];

class HomeControllerMock extends HomeController {
  HomeControllerMock()
      : super(HomeModel(
            events: mockEvents, itemIds: ['1', '2', '3', '4', '5', '6']));
}
