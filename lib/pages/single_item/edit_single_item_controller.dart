import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/pages/single_item/single_item_view.dart';
import 'package:device_calendar/device_calendar.dart';
import 'model/single_item.dart';
import 'edit_single_item_view.dart';
import 'single_item_controller.dart';
import 'model/item_event.dart';

import '/common/provider.dart';

class EditSingleItemControllerMock extends EditSingleItemController {
  EditSingleItemControllerMock({required int id, SingleItem? model})
      : _id = id,
        super(model ?? mockSingleItem);

  List<ItemEvent> newEvents = [];
  List<ItemEvent> deletedEvents = [];
  final int _id;
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
    removeEventsFromCalendar();
    addEventsToCalendar();
    state = state.copyWith(events: [...state.events, ...newEvents]);

    SingleItemController singleItemController =
        ref.read(Providers.singleItemControllerProvider(_id).notifier);
    singleItemController.state = state;
  }

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
  void addEvent({required Event event, required int parentId}) async {
    newEvents.add(ItemEvent(id: 0, event: event, parentId: parentId));
    state = state.copyWith(events: [...state.events]);
  }

  @override
  void removeEvent(ItemEvent event) {
    if (event.event.eventId == null) {
      newEvents.remove(event);
    } else {
      deletedEvents.add(event);
    }

    state = state.copyWith(
        events: List<ItemEvent>.from(state.events)..remove(event));
  }

  @override
  List<ItemEvent> getEvents() {
    return List<ItemEvent>.from(state.events + newEvents);
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

  void addEventsToCalendar() {
    DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    newEvents.forEach((event) async {
      var eventId = await deviceCalendarPlugin.createOrUpdateEvent(event.event);
      event.event.eventId = eventId?.data!;
    });
  }

  void removeEventsFromCalendar() {
    DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    deletedEvents.forEach((event) async {
      var res = await deviceCalendarPlugin.deleteEvent(
          event.event.calendarId!, event.event.eventId!);
    });
  }

  @override
  void navigateToThisItem() {
    throw UnimplementedError('Cannot navigate to items used in edit view');
  }
}
