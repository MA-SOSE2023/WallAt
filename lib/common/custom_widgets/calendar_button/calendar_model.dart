import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_model.freezed.dart';

final Map<RecurrenceRule?, String> recurrenceOptions = {
  null: 'None',
  RecurrenceRule(RecurrenceFrequency.Daily): 'Daily',
  RecurrenceRule(RecurrenceFrequency.Weekly): 'Weekly',
  RecurrenceRule(RecurrenceFrequency.Monthly): 'Monthly',
  RecurrenceRule(RecurrenceFrequency.Yearly): 'Yearly',
};

@freezed
class CalendarModel with _$CalendarModel {
  const factory CalendarModel({
    @Default('') String title,
    @Default('') String description,
    required DateTime? startDate,
    required DateTime? endDate,
    @Default(0) int selectedRecurrenceIndex,
    @Default(0) int selectedReminderMinutes,
  }) = _CalendarModel;
}
