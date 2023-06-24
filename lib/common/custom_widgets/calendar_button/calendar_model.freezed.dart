// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CalendarModel {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  int get selectedRecurrenceIndex => throw _privateConstructorUsedError;
  int get selectedReminderMinutes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalendarModelCopyWith<CalendarModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarModelCopyWith<$Res> {
  factory $CalendarModelCopyWith(
          CalendarModel value, $Res Function(CalendarModel) then) =
      _$CalendarModelCopyWithImpl<$Res, CalendarModel>;
  @useResult
  $Res call(
      {String title,
      String description,
      DateTime? startDate,
      DateTime? endDate,
      int selectedRecurrenceIndex,
      int selectedReminderMinutes});
}

/// @nodoc
class _$CalendarModelCopyWithImpl<$Res, $Val extends CalendarModel>
    implements $CalendarModelCopyWith<$Res> {
  _$CalendarModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? selectedRecurrenceIndex = null,
    Object? selectedReminderMinutes = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedRecurrenceIndex: null == selectedRecurrenceIndex
          ? _value.selectedRecurrenceIndex
          : selectedRecurrenceIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedReminderMinutes: null == selectedReminderMinutes
          ? _value.selectedReminderMinutes
          : selectedReminderMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CalendarModelCopyWith<$Res>
    implements $CalendarModelCopyWith<$Res> {
  factory _$$_CalendarModelCopyWith(
          _$_CalendarModel value, $Res Function(_$_CalendarModel) then) =
      __$$_CalendarModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      DateTime? startDate,
      DateTime? endDate,
      int selectedRecurrenceIndex,
      int selectedReminderMinutes});
}

/// @nodoc
class __$$_CalendarModelCopyWithImpl<$Res>
    extends _$CalendarModelCopyWithImpl<$Res, _$_CalendarModel>
    implements _$$_CalendarModelCopyWith<$Res> {
  __$$_CalendarModelCopyWithImpl(
      _$_CalendarModel _value, $Res Function(_$_CalendarModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? selectedRecurrenceIndex = null,
    Object? selectedReminderMinutes = null,
  }) {
    return _then(_$_CalendarModel(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedRecurrenceIndex: null == selectedRecurrenceIndex
          ? _value.selectedRecurrenceIndex
          : selectedRecurrenceIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedReminderMinutes: null == selectedReminderMinutes
          ? _value.selectedReminderMinutes
          : selectedReminderMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_CalendarModel implements _CalendarModel {
  const _$_CalendarModel(
      {this.title = '',
      this.description = '',
      required this.startDate,
      required this.endDate,
      this.selectedRecurrenceIndex = 0,
      this.selectedReminderMinutes = 0});

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final int selectedRecurrenceIndex;
  @override
  @JsonKey()
  final int selectedReminderMinutes;

  @override
  String toString() {
    return 'CalendarModel(title: $title, description: $description, startDate: $startDate, endDate: $endDate, selectedRecurrenceIndex: $selectedRecurrenceIndex, selectedReminderMinutes: $selectedReminderMinutes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CalendarModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(
                    other.selectedRecurrenceIndex, selectedRecurrenceIndex) ||
                other.selectedRecurrenceIndex == selectedRecurrenceIndex) &&
            (identical(
                    other.selectedReminderMinutes, selectedReminderMinutes) ||
                other.selectedReminderMinutes == selectedReminderMinutes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, description, startDate,
      endDate, selectedRecurrenceIndex, selectedReminderMinutes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CalendarModelCopyWith<_$_CalendarModel> get copyWith =>
      __$$_CalendarModelCopyWithImpl<_$_CalendarModel>(this, _$identity);
}

abstract class _CalendarModel implements CalendarModel {
  const factory _CalendarModel(
      {final String title,
      final String description,
      required final DateTime? startDate,
      required final DateTime? endDate,
      final int selectedRecurrenceIndex,
      final int selectedReminderMinutes}) = _$_CalendarModel;

  @override
  String get title;
  @override
  String get description;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  int get selectedRecurrenceIndex;
  @override
  int get selectedReminderMinutes;
  @override
  @JsonKey(ignore: true)
  _$$_CalendarModelCopyWith<_$_CalendarModel> get copyWith =>
      throw _privateConstructorUsedError;
}
