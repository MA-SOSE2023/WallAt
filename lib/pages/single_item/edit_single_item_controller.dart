import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/pages/single_item/single_item_view.dart';
import 'package:device_calendar/device_calendar.dart';
import 'model/single_item.dart';
import 'edit_single_item_view.dart';
import 'single_item_controller.dart';
import 'model/single_item.dart';
import 'model/item_event.dart';

import '/common/provider.dart';
import '/pages/single_item/single_item_view.dart';

class EditSingleItemControllerMock extends EditSingleItemController {
  EditSingleItemControllerMock({required String id, SingleItem? model})
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
  void saveChanges(WidgetRef ref) {
    SingleItemController singleItemController =
        ref.read(Providers.singleItemControllerProvider(_id).notifier);
    singleItemController.state = state;
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
  void addEvent(ItemEvent event) async {
    DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    var eventId = await deviceCalendarPlugin.createOrUpdateEvent(event.event);
    event.event.eventId = eventId?.data!;

    state = state.copyWith(events: [...state.events, event]);
  }

  @override
  void removeEvent(ItemEvent event) {
    DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    deviceCalendarPlugin.deleteEvent(
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
    throw UnimplementedError('Cannot navigate to items used in edit view');
  }
}
