import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:gruppe4/common/utils/future_controller_mixin.dart';

import 'edit_single_item_view.dart';
import 'model/single_item.dart';
import 'model/item_event.dart';
import '/common/provider.dart';
import '/pages/single_item/single_item_view.dart';

class EditSingleItemControllerImpl extends EditSingleItemController
    with FutureControllerMixin<SingleItem> {
  EditSingleItemControllerImpl({required Future<SingleItem> model})
      : super(model);

  List<ItemEvent> newEvents = [];
  List<ItemEvent> deletedEvents = [];
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
  Future<void> saveChanges(WidgetRef ref) async {
    removeEventsFromCalendar();
    addEventsToCalendar();
    futureState(
        (state) => state.copyWith(events: [...state.events, ...newEvents]));

    SingleItemController singleItemController = ref.read(
        Providers.singleItemControllerProvider((await state).id).notifier);
    singleItemController.state = Future.value(state);
  }

  @override
  void setImage(Image image) =>
      futureState((state) => state.copyWith(image: image.image));

  @override
  void setDescription(String description) =>
      futureState((state) => state.copyWith(description: description));

  @override
  void setTitle(String title) =>
      futureState((state) => state.copyWith(title: title));

  @override
  void addEvent({required Event event, required int parentId}) async {
    newEvents.add(ItemEvent(id: 0, event: event, parentId: parentId));
    futureState((state) => state.copyWith(events: [...state.events]));
  }

  @override
  void removeEvent(ItemEvent event) {
    if (event.event.eventId == null) {
      newEvents.remove(event);
    } else {
      deletedEvents.add(event);
    }

    futureState((state) => state.copyWith(
        events: List<ItemEvent>.from(state.events)..remove(event)));
  }

  @override
  void setFavorite() => futureState(
      (state) => state.copyWith(isFavorite: state.isFavorite ? false : true));

  void addEventsToCalendar() async {
    DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    for (ItemEvent event in newEvents) {
      var eventId = await deviceCalendarPlugin.createOrUpdateEvent(event.event);
      event.event.eventId = eventId?.data!;
    }
  }

  Future<void> removeEventsFromCalendar() async {
    DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    for (ItemEvent event in newEvents) {
      await deviceCalendarPlugin.deleteEvent(
          event.event.calendarId!, event.event.eventId!);
    }
  }

  @override
  void navigateToThisItem() {
    throw UnimplementedError('Cannot navigate to items used in edit view');
  }
}
