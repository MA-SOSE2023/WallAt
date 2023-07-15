import 'package:device_calendar/device_calendar.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/common/localization/language.dart';

part 'calendar_model.freezed.dart';

Map<RecurrenceRule?, String> recurrenceOptions(Language language) => {
      null: language.lblRecurrenceNever,
      RecurrenceRule(RecurrenceFrequency.Daily): language.lblRecurrenceDaily,
      RecurrenceRule(RecurrenceFrequency.Weekly): language.lblRecurrenceWeekly,
      RecurrenceRule(RecurrenceFrequency.Monthly):
          language.lblRecurrenceMonthly,
      RecurrenceRule(RecurrenceFrequency.Yearly): language.lblRecurrenceYearly,
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
