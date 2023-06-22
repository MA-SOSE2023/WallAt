import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_event.freezed.dart';

@freezed
class ItemEvent with _$ItemEvent {
  const factory ItemEvent({
    required String description,
    required DateTime date,
    required String parentId,
  }) = _ItemEvent;
}
