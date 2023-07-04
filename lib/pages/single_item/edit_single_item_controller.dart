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
        _previousState = state.toSingleItem();

  final SingleItem _previousState;
  final SingleItemController _singleItemController;

  @override
  Future<void> saveChanges() async {
    await removeEventsFromCalendar();
    await addEventsToCalendar();

    _singleItemController.updateItem(state.toSingleItem());
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
    ItemEvent newEvent = ItemEvent(id: -1, event: event, parentId: state.id);
    state = state.copyWith(
      events: [...state.events, newEvent],
      addedEvents: [...state.addedEvents, newEvent],
    );
  }

  @override
  Future<void> removeEvent(ItemEvent event) async {
    if (event.id == -1) {
      state = state.copyWith(
        events: state.events.where((e) => e != event).toList(),
        addedEvents: state.addedEvents.where((e) => e != event).toList(),
      );
    } else {
      state = state.copyWith(
        events: [...state.events.where((e) => e != event)],
        deletedEvents: [...state.deletedEvents, event],
      );
    }
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
    for (ItemEvent event in state.addedEvents) {
      await _singleItemController.addEvent(
          event: event.event, parentId: state.id);
    }
  }

  Future<void> removeEventsFromCalendar() async {
    _singleItemController.removeEvents(state.deletedEvents);
  }

  @override
  Future<void> navigateToThisItem() {
    throw UnimplementedError('Cannot navigate to items used in edit view');
  }

  @override
  Future<void> deleteItem() => _singleItemController.deleteItem();
}
