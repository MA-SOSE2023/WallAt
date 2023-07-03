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
    removeEventsFromCalendar();
    addEventsToCalendar();

    if (_previousState.isFavorite != state.isFavorite) {
      _singleItemController.toggleFavorite();
    }
    if (_previousState.title != state.title) {
      _singleItemController.setTitle(state.title);
    }
    if (_previousState.description != state.description) {
      _singleItemController.setDescription(state.description);
    }
    if (_previousState.image != state.image) {
      _singleItemController.setImage(state.image);
    }
  }

  @override
  void setImage(ImageProvider image) => state = state.copyWith(image: image);

  @override
  void setDescription(String description) =>
      state = state.copyWith(description: description);

  @override
  void setTitle(String title) => state = state.copyWith(title: title);

  @override
  void addEvent({required Event event, required int parentId}) async {
    newEvents.add(event);
    state = state.copyWith(events: [
      ...state.events,
      ItemEvent(id: -1, event: event, parentId: state.id)
    ]);
  }

  @override
  void removeEvent(ItemEvent event) {
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
  void toggleFavorite() =>
      state = state.copyWith(isFavorite: !state.isFavorite);

  void addEventsToCalendar() async {
    for (Event event in newEvents) {
      _singleItemController.addEvent(event: event, parentId: state.id);
    }
  }

  Future<void> removeEventsFromCalendar() async {
    for (ItemEvent event in deletedEvents) {
      _singleItemController.removeEvent(event);
    }
  }

  @override
  void navigateToThisItem() {
    throw UnimplementedError('Cannot navigate to items used in edit view');
  }

  @override
  void deleteItem() => _singleItemController.deleteItem();
}
