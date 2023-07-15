import 'dart:async';

import 'home_model.dart';
import 'home_view.dart';
import '/pages/single_item/model/item_event.dart';
import '/pages/single_item/model/single_item.dart';
import '/common/provider.dart';
import '/common/services/persistence/persistence_service.dart';

class HomeControllerImpl extends HomeController {
  @override
  FutureOr<HomeModel> build() async {
    final PersistenceService service =
        ref.watch(Providers.persistenceServiceProvider);
    final List<SingleItem> recentItems = await service.getRecentItems();
    final List<ItemEvent> soonEvents = await service.getSoonEvents();
    for (SingleItem item in recentItems) {
      ref.listen(Providers.singleItemControllerProvider(item.id),
          (previous, next) {
        state = ref.refresh(Providers.homeControllerProvider);
      });
    }
    return HomeModel(recentItems: recentItems, events: soonEvents);
  }
}
