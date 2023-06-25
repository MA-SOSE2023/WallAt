import 'package:device_calendar/device_calendar.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_event.freezed.dart';

@freezed
class ItemEvent with _$ItemEvent {
  const factory ItemEvent({
    required Event event,
    required String parentId,
  }) = _ItemEvent;
}
