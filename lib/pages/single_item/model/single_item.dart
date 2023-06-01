import 'package:freezed_annotation/freezed_annotation.dart';

part 'single_item.freezed.dart';

@freezed
class SingleItem with _$SingleItem {
  const factory SingleItem({
    required String title,
    required String description,
    required String image,
  }) = _SingleItem;
}
