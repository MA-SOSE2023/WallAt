import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/provider.dart';
import 'model/single_item.dart';
import 'model/item_event.dart';
import '/pages/single_item/single_item_view.dart';
import '/common/utils/future_controller_mixin.dart';
import '/common/services/persistence/persistence_service.dart';
import '/router/router.dart';

var mockSingleItem = SingleItem(
  id: 0,
  title: 'You should not see this',
  description: 'How did you get here?',
  image: const AssetImage('assets/dev_debug_images/hampter1.jpg'),
  isFavorite: false,
  events: [],
);

class SingleItemControllerImpl extends SingleItemController
    with FutureControllerMixin {
  SingleItemControllerImpl(
      {required int id, required PersistenceService service})
      : _service = service,
        super(service.getSingleItem(id).then((item) => item ?? mockSingleItem));

  final PersistenceService _service;

  @override
  set state(Future<SingleItem> value) {
    super.state = value.then((item) {
      _service.updateSingleItem(item);
      return item;
    });
  }

  @override
  void setImage(Image image) {
    futureState((state) => state.copyWith(image: image.image));
  }

  @override
  void setDescription(String description) {
    futureState((state) => state.copyWith(description: description));
  }

  @override
  void setTitle(String title) {
    futureState((state) => state.copyWith(title: title));
  }

  @override
  void addEvent({required Event event, required int parentId}) {
    futureState((state) => state.copyWith(events: [
          ...state.events,
          ItemEvent(id: 0, event: event, parentId: parentId)
        ]));
  }

  @override
  void removeEvent(ItemEvent event) {
    DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    deviceCalendarPlugin.deleteEvent(
        event.event.calendarId!, event.event.eventId!);
    _service.deleteEvent(event);

    futureState((state) => state.copyWith(
        events: List<ItemEvent>.from(state.events)..remove(event)));
  }

  @override
  void setFavorite() {
    futureState(
        (state) => state.copyWith(isFavorite: state.isFavorite ? false : true));
  }

  @override
  void navigateToThisItem() async {
    Routers.globalRouterDelegate.beamToNamed('/item', data: await state);
  }

  @override
  Future<bool> deleteItem(WidgetRef ref) => state.then((item) async {
        item.events.forEach(removeEvent);
        return ref
            .read(Providers.dbControllerProvider.notifier)
            .rootFolderId
            .then((rootId) => ref
                .read(Providers.foldersControllerProvider(rootId).notifier)
                .removeItem(item));
      });
}
