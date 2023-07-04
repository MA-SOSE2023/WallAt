import 'dart:async';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Future<void> setImage(ImageProvider image) async {
    state = state.whenData((item) {
      if (item != null) {
        final SingleItem updated = item.copyWith(image: image);
        persistence.updateSingleItem(updated);
        return updated;
      }
      return item;
    });
  }

  @override
  Future<void> setDescription(String description) async {
    state = state.whenData((item) {
      if (item != null) {
        final SingleItem updated = item.copyWith(description: description);
        persistence.updateSingleItem(updated);
        return updated;
      }
      return item;
    });
  }

  @override
  Future<void> setTitle(String title) async {
    state = state.whenData((item) {
      if (item != null) {
        final SingleItem updated = item.copyWith(title: title);
        persistence.updateSingleItem(updated);
        return updated;
      }
      return item;
    });
  }

  @override
  Future<void> addEvent({required Event event, required int parentId}) async {
    final Result<String>? addedEventId = await addEventToCalendar(event);
    print('addedEventResultId: ${addedEventId?.data}');
    if (addedEventId != null && addedEventId.isSuccess) {
      final ItemEvent addedEvent = await persistence.createEvent(
          event: copyEventWithId(event, addedEventId.data),
          parentItemId: parentId);
      await updateState(
          (item) => item.copyWith(events: [...item.events, addedEvent]));
      print('single item added event: ${event.title}');
      // invalidate home controller since the event might be in the home list
      ref.invalidate(Providers.homeControllerProvider);
    }
  }

  @override
  Future<void> removeEvent(ItemEvent event) async {
    await removeEventFromCalendar(event.event);
    await persistence.deleteEvent(event);
    await updateState((item) =>
        item.copyWith(events: [...item.events.where((e) => e != event)]));
    print('single item removed event: ${event.event.title}');
    // invalidate home controller since the event might be in the home list
    ref.invalidate(Providers.homeControllerProvider);
  }

  @override
  Future<void> removeEvents(List<ItemEvent> events) async {
    for (final event in events) {
      await removeEventFromCalendar(event.event);
      await persistence.deleteEvent(event);
      print('single item removed event: ${event.event.title}');
    }
    await updateState((item) => item
        .copyWith(events: [...item.events.where((e) => !events.contains(e))]));
    // invalidate home controller since the event might be in the home list
    ref.invalidate(Providers.homeControllerProvider);
  }

  @override
  Future<void> toggleFavorite() =>
      updateState((item) => item.copyWith(isFavorite: !item.isFavorite));

  @override
  Future<void> navigateToThisItem() async => state.whenData(
      (item) => Routers.globalRouterDelegate.beamToNamed('/item', data: item));

  @override
  Future<void> deleteItem() async => state.whenData(
        (item) async {
          item?.events.forEach(removeEvent);
          if (item != null) {
            Folder? parent = await persistence.getParentFolder(item);
            if (parent != null) {
              ref
                  .read(Providers.foldersControllerProvider(parent.id).notifier)
                  .removeItem(item);
            }
            ref.invalidateSelf();
          }
        },
      );
}
