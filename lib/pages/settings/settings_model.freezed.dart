// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingsModel {
  Calendar? get calendar => throw _privateConstructorUsedError;
  int get selectedThemeIndex => throw _privateConstructorUsedError;
  int? get selectedProfileId => throw _privateConstructorUsedError;
  Language get language => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsModelCopyWith<SettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsModelCopyWith<$Res> {
  factory $SettingsModelCopyWith(
          SettingsModel value, $Res Function(SettingsModel) then) =
      _$SettingsModelCopyWithImpl<$Res, SettingsModel>;
  @useResult
  $Res call(
      {Calendar? calendar,
      int selectedThemeIndex,
      int? selectedProfileId,
      Language language});
}

/// @nodoc
class _$SettingsModelCopyWithImpl<$Res, $Val extends SettingsModel>
    implements $SettingsModelCopyWith<$Res> {
  _$SettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calendar = freezed,
    Object? selectedThemeIndex = null,
    Object? selectedProfileId = freezed,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      calendar: freezed == calendar
          ? _value.calendar
          : calendar // ignore: cast_nullable_to_non_nullable
              as Calendar?,
      selectedThemeIndex: null == selectedThemeIndex
          ? _value.selectedThemeIndex
          : selectedThemeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedProfileId: freezed == selectedProfileId
          ? _value.selectedProfileId
          : selectedProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SettingsModelCopyWith<$Res>
    implements $SettingsModelCopyWith<$Res> {
  factory _$$_SettingsModelCopyWith(
          _$_SettingsModel value, $Res Function(_$_SettingsModel) then) =
      __$$_SettingsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Calendar? calendar,
      int selectedThemeIndex,
      int? selectedProfileId,
      Language language});
}

/// @nodoc
class __$$_SettingsModelCopyWithImpl<$Res>
    extends _$SettingsModelCopyWithImpl<$Res, _$_SettingsModel>
    implements _$$_SettingsModelCopyWith<$Res> {
  __$$_SettingsModelCopyWithImpl(
      _$_SettingsModel _value, $Res Function(_$_SettingsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calendar = freezed,
    Object? selectedThemeIndex = null,
    Object? selectedProfileId = freezed,
    Object? language = null,
  }) {
    return _then(_$_SettingsModel(
      calendar: freezed == calendar
          ? _value.calendar
          : calendar // ignore: cast_nullable_to_non_nullable
              as Calendar?,
      selectedThemeIndex: null == selectedThemeIndex
          ? _value.selectedThemeIndex
          : selectedThemeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedProfileId: freezed == selectedProfileId
          ? _value.selectedProfileId
          : selectedProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language,
    ));
  }
}

/// @nodoc

class _$_SettingsModel implements _SettingsModel {
  const _$_SettingsModel(
      {this.calendar,
      required this.selectedThemeIndex,
      this.selectedProfileId,
      required this.language});

  @override
  final Calendar? calendar;
  @override
  final int selectedThemeIndex;
  @override
  final int? selectedProfileId;
  @override
  final Language language;

  @override
  String toString() {
    return 'SettingsModel(calendar: $calendar, selectedThemeIndex: $selectedThemeIndex, selectedProfileId: $selectedProfileId, language: $language)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingsModel &&
            (identical(other.calendar, calendar) ||
                other.calendar == calendar) &&
            (identical(other.selectedThemeIndex, selectedThemeIndex) ||
                other.selectedThemeIndex == selectedThemeIndex) &&
            (identical(other.selectedProfileId, selectedProfileId) ||
                other.selectedProfileId == selectedProfileId) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, calendar, selectedThemeIndex, selectedProfileId, language);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingsModelCopyWith<_$_SettingsModel> get copyWith =>
      __$$_SettingsModelCopyWithImpl<_$_SettingsModel>(this, _$identity);
}

abstract class _SettingsModel implements SettingsModel {
  const factory _SettingsModel(
      {final Calendar? calendar,
      required final int selectedThemeIndex,
      final int? selectedProfileId,
      required final Language language}) = _$_SettingsModel;

  @override
  Calendar? get calendar;
  @override
  int get selectedThemeIndex;
  @override
  int? get selectedProfileId;
  @override
  Language get language;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsModelCopyWith<_$_SettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
