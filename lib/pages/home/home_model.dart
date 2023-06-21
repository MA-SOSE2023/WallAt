import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gruppe4/pages/single_item/model/item_event.dart';

part 'home_model.freezed.dart';

@freezed
class HomeModel with _$HomeModel {
  const factory HomeModel({
    required List<ItemEvent> events,
  }) = _HomeModel;
}
