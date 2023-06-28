import 'package:gruppe4/common/services/persistence/persistence_service.dart';

import 'home_model.dart';
import 'home_view.dart';

class HomeControllerImpl extends HomeController {
  HomeControllerImpl(PersistenceService service)
      : super(service
            .getSoonEvents()
            .then((events) => service.getRecentItems().then(
                  (items) => HomeModel(events: events, recentItems: items),
                )));
}
