import 'favorites_view.dart';

import '/pages/single_item/model/single_item.dart';
import '/common/services/persistence/persistence_service.dart';

class FavoritesControllerImpl extends FavoritesController {
  FavoritesControllerImpl(PersistenceService service)
      : _service = service,
        super(service.getFavoriteItems());

  final PersistenceService _service;

  @override
  Future<List<SingleItem>> get favorites {
    return state.then((value) => _service.getFavoriteItems());
  }

  @override
  Future<List<SingleItem>> filterFavorites(String searchString) {
    return favorites.then(
      (favorites) {
        if (searchString.isEmpty) {
          return favorites;
        } else {
          return favorites
              .where((item) =>
                  item.title.toLowerCase().contains(searchString.toLowerCase()))
              .toList();
        }
      },
    );
  }
}
