import 'package:flutter/cupertino.dart';

import 'model/single_item.dart';
import 'single_item_view.dart';

const mockSingleItem = SingleItem(
  title: 'Example Title',
  description: 'Example Description',
  image: 'assets/dev_debug_images/hampter1.jpg',
);

class SingleItemControllerMock extends SingleItemController {
  SingleItemControllerMock({required String id, SingleItem? model})
      : _id = id,
        super(model ?? mockSingleItem);

  final String _id;

  @override
  Image getImage() {
    return Image.asset(state.image);
  }

  @override
  String getDescription() {
    return state.description;
  }

  @override
  void setDescription(String text) {
    state = state.copyWith(description: text);
  }
}
