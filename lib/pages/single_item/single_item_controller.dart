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
  Future<void> persistUpdate(SingleItem updated) =>
      persistence.updateSingleItem(updated);

  @override
  void setImage(ImageProvider image) {
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
  void setDescription(String description) {
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
  void setTitle(String title) {
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
    if (addedEventId != null && addedEventId.isSuccess) {
      final ItemEvent addedEvent = await persistence.createEvent(
          event: copyEventWithId(event, addedEventId.data),
          parentItemId: parentId);
      updateState(
          (item) => item.copyWith(events: item.events..add(addedEvent)));
    }
  }

  @override
  void removeEvent(ItemEvent event) {
    addEventToCalendar(event.event);
    persistence.deleteEvent(event);
    updateState((item) => item.copyWith(events: item.events..remove(event)));
  }

  @override
  void toggleFavorite() =>
      updateState((item) => item.copyWith(isFavorite: !item.isFavorite));

  @override
  void navigateToThisItem() => state.whenData(
      (item) => Routers.globalRouterDelegate.beamToNamed('/item', data: item));

  @override
  void deleteItem() => state.whenData(
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
