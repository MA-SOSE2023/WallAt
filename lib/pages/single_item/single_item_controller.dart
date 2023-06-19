import 'package:flutter/cupertino.dart';

import 'model/single_item.dart';
import 'model/item_event.dart';
import 'single_item_view.dart';

const mockSingleItem = SingleItem(
  title: 'Example Title',
  description: 'Example Description',
  image: 'assets/dev_debug_images/example_document.png',
  isFavorite: false,
  events: [],
  currentSelectedDate: null,
);

class SingleItemControllerMock extends SingleItemController {
  SingleItemControllerMock({required String id, SingleItem? model})
      : _id = id,
        super(model ?? mockSingleItem);

  final String _id;
  DateTime? _selectedDate;

  @override
  DateTime? getSelectedDate() {
    return _selectedDate;
  }

  @override
  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
  }

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
  void setDescription(String text) {
    state = state.copyWith(description: text);
  }

  @override
  String getTitle() {
    return state.title;
  }

  @override
  void setTitle(String text) {
    state = state.copyWith(title: text);
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
}
