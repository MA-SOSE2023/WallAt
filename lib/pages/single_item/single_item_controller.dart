import 'package:flutter/cupertino.dart';

import 'model/single_item.dart';
import 'model/item_event.dart';
import '/pages/single_item/single_item_view.dart';
import '/router/router.dart';

var mockSingleItem = SingleItem(
  title: 'Example Title',
  description: 'Example Description',
  image: 'assets/dev_debug_images/hampter1.jpg',
  isFavorite: false,
  events: [
    ItemEvent(
        description: "Example Event", date: DateTime.now(), parentId: '1'),
    ItemEvent(
        description: "Example Event", date: DateTime.now(), parentId: '1'),
    ItemEvent(description: "Example Event", date: DateTime.now(), parentId: '1')
  ],
  currentSelectedDate: null,
);

class SingleItemControllerMock extends SingleItemController {
  SingleItemControllerMock({required String id, SingleItem? model})
      : _id = id,
        super(model ?? mockSingleItem);

  final String _id;

  @override
  Image getImage() {
    return Image.asset(state.image);
  }

  @override
  void setImage(Image image) {
    state = state.copyWith(image: image.toString());
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
  void addEvent(ItemEvent event) {
    state = state.copyWith(events: [...state.events, event]);
  }

  @override
  void removeEvent(ItemEvent event) {
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
