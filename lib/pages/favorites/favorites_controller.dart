import 'favorites_view.dart';

List<String> mockItems = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
];

class FavoritesControllerMock extends FavoritesController {
  FavoritesControllerMock() : super(mockItems);

  @override
  List<String> get favorites => state;
}
