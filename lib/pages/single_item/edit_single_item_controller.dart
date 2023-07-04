import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_calendar/device_calendar.dart';

import 'edit_single_item_view.dart';
import 'model/item_event.dart';
import '/common/utils/device_calendar_mixin.dart';
import '/pages/single_item/single_item_view.dart';
import 'model/single_item.dart';

class EditSingleItemControllerImpl extends EditSingleItemController
    with DeviceCalendarMixin {
  EditSingleItemControllerImpl(super.state,
      {required SingleItemController controller})
      : _singleItemController = controller,
        _previousState = state;

  List<Event> newEvents = [];
  List<ItemEvent> deletedEvents = [];
  DateTime? _selectedDate;

  final SingleItem _previousState;
  final SingleItemController _singleItemController;

  @override
  DateTime? getSelectedDate() {
    return _selectedDate;
  }

  @override
  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
  }

  @override
  Future<void> saveChanges() async {
    await removeEventsFromCalendar();
    await addEventsToCalendar();

    if (_previousState.isFavorite != state.isFavorite) {
      await _singleItemController.toggleFavorite();
    }
    if (_previousState.title != state.title) {
      await _singleItemController.setTitle(state.title);
    }
    if (_previousState.description != state.description) {
      await _singleItemController.setDescription(state.description);
    }
    if (_previousState.image != state.image) {
      await _singleItemController.setImage(state.image);
    }
  }

  @override
  Future<void> setImage(ImageProvider image) async =>
      state = state.copyWith(image: image);

  @override
  Future<void> setDescription(String description) async =>
      state = state.copyWith(description: description);

  @override
  Future<void> setTitle(String title) async =>
      state = state.copyWith(title: title);

  @override
  Future<void> addEvent({required Event event, required int parentId}) async {
    print('added event: $event');
    newEvents.add(event);
    state = state.copyWith(events: [
      ...state.events,
      ItemEvent(id: -1, event: event, parentId: state.id)
    ]);
  }

  @override
  Future<void> removeEvent(ItemEvent event) async {
    print('removed event: $event');
    if (event.id == -1) {
      newEvents.remove(event.event);
    } else {
      deletedEvents.add(event);
    }

    state = state.copyWith(
      events: [...state.events.where((e) => e != event)],
    );
  }

  @override
  Future<void> removeEvents(List<ItemEvent> events) async {
    for (final event in events) {
      removeEvent(event);
    }
  }

  @override
  Future<void> toggleFavorite() async =>
      state = state.copyWith(isFavorite: !state.isFavorite);

  Future<void> addEventsToCalendar() async {
    for (Event event in newEvents) {
      _singleItemController.addEvent(event: event, parentId: state.id);
    }
  }

  Future<void> removeEventsFromCalendar() async {
    _singleItemController.removeEvents(deletedEvents);
  }

  @override
  Future<void> navigateToThisItem() {
    throw UnimplementedError('Cannot navigate to items used in edit view');
  }

  @override
  Future<void> deleteItem() => _singleItemController.deleteItem();
}
