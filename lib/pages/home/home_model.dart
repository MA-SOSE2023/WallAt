import 'package:freezed_annotation/freezed_annotation.dart';

import '/pages/single_item/model/single_item.dart';
import '/pages/single_item/model/item_event.dart';

part 'home_model.freezed.dart';

@freezed
class HomeModel with _$HomeModel {
  const factory HomeModel({
    required List<ItemEvent> events,
    required List<SingleItem> recentItems,
  }) = _HomeModel;
}
