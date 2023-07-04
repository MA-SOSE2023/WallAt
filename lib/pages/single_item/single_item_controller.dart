import 'dart:async';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';

import 'model/single_item.dart';
import 'model/item_event.dart';

import '/pages/folders/folder_model.dart';
import '/pages/single_item/single_item_view.dart';
import '/common/provider.dart';
import '/common/utils/device_calendar_mixin.dart';
import '/common/utils/async_persisting_controller_mixin.dart';
import '/router/router.dart';

class SingleItemControllerImpl extends SingleItemController
    with AutoDisposeAsyncPersistingControllerMixin, DeviceCalendarMixin {
  @override
  FutureOr<SingleItem?> build(int arg) => persistence.getSingleItem(arg);

  @override
  Future<void> persistUpdate(SingleItem updated) {
    return persistence.updateSingleItem(updated);
  }

  @override
  Future<void> setImage(ImageProvider image) async =>
      updateState((item) => item.copyWith(image: image));

  @override
  Future<void> setDescription(String description) async =>
      updateState((item) => item.copyWith(description: description));

  @override
  Future<void> setTitle(String title) async =>
      updateState((item) => item.copyWith(title: item.title));

  @override
  Future<void> addEvent({required Event event, required int parentId}) async {
    final Result<String>? addedEventId = await addEventToCalendar(event);
    if (addedEventId != null && addedEventId.isSuccess) {
      final ItemEvent addedEvent = await persistence.createEvent(
          event: copyEventWithId(event, addedEventId.data),
          parentItemId: parentId);
      return updateState(
          (item) => item.copyWith(events: [...item.events, addedEvent]));
    }
  }

  @override
  Future<void> removeEvent(ItemEvent event) async {
    await removeEventFromCalendar(event.event);
    await persistence.deleteEvent(event);
    return updateState((item) =>
        item.copyWith(events: [...item.events.where((e) => e != event)]));
  }

  @override
  Future<void> removeEvents(List<ItemEvent> events) async {
    for (final event in events) {
      await removeEventFromCalendar(event.event);
      await persistence.deleteEvent(event);
    }
    return updateState((item) => item
        .copyWith(events: [...item.events.where((e) => !events.contains(e))]));
  }

  @override
  Future<void> toggleFavorite() async =>
      updateState((item) => item.copyWith(isFavorite: !item.isFavorite));

  @override
  Future<void> navigateToThisItem() async {
    final SingleItem? item = await future;
    Routers.globalRouterDelegate.beamToNamed('/item', data: item);
  }

  @override
  Future<void> deleteItem() async {
    final SingleItem? item = await future;
    if (item != null) {
      for (ItemEvent event in item.events) {
        await removeEventFromCalendar(event.event);
      }
      Folder? parent = await persistence.getParentFolder(item);
      if (parent != null) {
        ref
            .read(Providers.foldersControllerProvider(parent.id).notifier)
            .removeItem(item);
      }
      ref.invalidateSelf();
      // invalidate favorites controller
      // since the item might be in their list
      ref.invalidate(Providers.favoritesControllerProvider);
    }
  }

  @override
  Future<void> updateItem(SingleItem item) {
    return updateState((state) => state.copyWith(
          title: item.title,
          description: item.description,
          image: item.image,
          events: item.events,
          isFavorite: item.isFavorite,
        ));
  }
}
