import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';

import 'model/single_item.dart';
import 'model/item_event.dart';
import '/pages/single_item/single_item_view.dart';
import '/router/router.dart';

var mockSingleItem = SingleItem(
  id: 1,
  title: 'Example Title',
  description: 'Example Description',
  image: const AssetImage('assets/dev_debug_images/hampter1.jpg'),
  isFavorite: false,
  events: [],
  currentSelectedDate: null,
);

class SingleItemControllerMock extends SingleItemController {
  SingleItemControllerMock({required int id, SingleItem? model})
      : _id = id,
        super(model ?? mockSingleItem.copyWith(id: id));

  final int _id;

  @override
  Image getImage() {
    return Image(image: state.image);
  }

  @override
  void setImage(Image image) {
    state = state.copyWith(image: image.image);
  }

  @override
  String getDescription() {
    return state.description;
  }

  @override
  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  @override
  String getTitle() {
    return state.title;
  }

  @override
  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  @override
  void addEvent({required Event event, required int parentId}) {
    state = state.copyWith(events: [
      ...state.events,
      ItemEvent(id: 0, event: event, parentId: parentId)
    ]);
  }

  @override
  void removeEvent(ItemEvent event) {
    DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    var res = deviceCalendarPlugin.deleteEvent(
        event.event.calendarId!, event.event.eventId!);

    state = state.copyWith(
        events: List<ItemEvent>.from(state.events)..remove(event));
  }

  @override
  List<ItemEvent> getEvents() {
    return List<ItemEvent>.from(state.events);
  }

  @override
  void setCurrentDate(DateTime date) {
    state = state.copyWith(currentSelectedDate: date);
  }

  @override
  DateTime? getCurrentDate() {
    return state.currentSelectedDate;
  }

  @override
  bool getFavorite() {
    return state.isFavorite;
  }

  @override
  void setFavorite() {
    state = state.copyWith(isFavorite: getFavorite() ? false : true);
  }

  @override
  void navigateToThisItem() {
    Routers.globalRouterDelegate.beamToNamed('/item/$_id');
  }
}
