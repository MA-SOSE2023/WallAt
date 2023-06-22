import 'package:freezed_annotation/freezed_annotation.dart';
import 'item_event.dart';

part 'single_item.freezed.dart';

@freezed
class SingleItem with _$SingleItem {
  const factory SingleItem({
    required String id,
    required String title,
    required String description,
    required String image,
    required bool isFavorite,
    required List<ItemEvent> events,
    DateTime? currentSelectedDate,
  }) = _SingleItem;
}
