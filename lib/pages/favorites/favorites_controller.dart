import '../single_item/model/single_item.dart';
import 'favorites_view.dart';
import '/common/services/persistence/persistence_service.dart';

class FavoritesControllerImpl extends FavoritesController {
  FavoritesControllerImpl(PersistenceService service)
      : super(service.getFavoriteItems());

  @override
  Future<List<SingleItem>> get favorites => state;
}
