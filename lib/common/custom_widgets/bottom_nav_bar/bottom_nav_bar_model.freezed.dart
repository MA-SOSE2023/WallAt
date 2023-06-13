// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_nav_bar_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomBottomNavBarModel {
  int get currentIndex => throw _privateConstructorUsedError;
  int get itemCount => throw _privateConstructorUsedError;
  double get iconSize => throw _privateConstructorUsedError;
  EdgeInsets get iconPadding => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomBottomNavBarModelCopyWith<CustomBottomNavBarModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomBottomNavBarModelCopyWith<$Res> {
  factory $CustomBottomNavBarModelCopyWith(CustomBottomNavBarModel value,
          $Res Function(CustomBottomNavBarModel) then) =
      _$CustomBottomNavBarModelCopyWithImpl<$Res, CustomBottomNavBarModel>;
  @useResult
  $Res call(
      {int currentIndex,
      int itemCount,
      double iconSize,
      EdgeInsets iconPadding});
}

/// @nodoc
class _$CustomBottomNavBarModelCopyWithImpl<$Res,
        $Val extends CustomBottomNavBarModel>
    implements $CustomBottomNavBarModelCopyWith<$Res> {
  _$CustomBottomNavBarModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentIndex = null,
    Object? itemCount = null,
    Object? iconSize = null,
    Object? iconPadding = null,
  }) {
    return _then(_value.copyWith(
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      itemCount: null == itemCount
          ? _value.itemCount
          : itemCount // ignore: cast_nullable_to_non_nullable
              as int,
      iconSize: null == iconSize
          ? _value.iconSize
          : iconSize // ignore: cast_nullable_to_non_nullable
              as double,
      iconPadding: null == iconPadding
          ? _value.iconPadding
          : iconPadding // ignore: cast_nullable_to_non_nullable
              as EdgeInsets,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CustomBottomNavBarModelCopyWith<$Res>
    implements $CustomBottomNavBarModelCopyWith<$Res> {
  factory _$$_CustomBottomNavBarModelCopyWith(_$_CustomBottomNavBarModel value,
          $Res Function(_$_CustomBottomNavBarModel) then) =
      __$$_CustomBottomNavBarModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentIndex,
      int itemCount,
      double iconSize,
      EdgeInsets iconPadding});
}

/// @nodoc
class __$$_CustomBottomNavBarModelCopyWithImpl<$Res>
    extends _$CustomBottomNavBarModelCopyWithImpl<$Res,
        _$_CustomBottomNavBarModel>
    implements _$$_CustomBottomNavBarModelCopyWith<$Res> {
  __$$_CustomBottomNavBarModelCopyWithImpl(_$_CustomBottomNavBarModel _value,
      $Res Function(_$_CustomBottomNavBarModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentIndex = null,
    Object? itemCount = null,
    Object? iconSize = null,
    Object? iconPadding = null,
  }) {
    return _then(_$_CustomBottomNavBarModel(
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      itemCount: null == itemCount
          ? _value.itemCount
          : itemCount // ignore: cast_nullable_to_non_nullable
              as int,
      iconSize: null == iconSize
          ? _value.iconSize
          : iconSize // ignore: cast_nullable_to_non_nullable
              as double,
      iconPadding: null == iconPadding
          ? _value.iconPadding
          : iconPadding // ignore: cast_nullable_to_non_nullable
              as EdgeInsets,
    ));
  }
}

/// @nodoc

class _$_CustomBottomNavBarModel implements _CustomBottomNavBarModel {
  const _$_CustomBottomNavBarModel(
      {this.currentIndex = 0,
      this.itemCount = 4,
      this.iconSize = CustomBottomNavBar.iconSize,
      this.iconPadding = EdgeInsets.zero});

  @override
  @JsonKey()
  final int currentIndex;
  @override
  @JsonKey()
  final int itemCount;
  @override
  @JsonKey()
  final double iconSize;
  @override
  @JsonKey()
  final EdgeInsets iconPadding;

  @override
  String toString() {
    return 'CustomBottomNavBarModel(currentIndex: $currentIndex, itemCount: $itemCount, iconSize: $iconSize, iconPadding: $iconPadding)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CustomBottomNavBarModel &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.iconSize, iconSize) ||
                other.iconSize == iconSize) &&
            (identical(other.iconPadding, iconPadding) ||
                other.iconPadding == iconPadding));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentIndex, itemCount, iconSize, iconPadding);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CustomBottomNavBarModelCopyWith<_$_CustomBottomNavBarModel>
      get copyWith =>
          __$$_CustomBottomNavBarModelCopyWithImpl<_$_CustomBottomNavBarModel>(
              this, _$identity);
}

abstract class _CustomBottomNavBarModel implements CustomBottomNavBarModel {
  const factory _CustomBottomNavBarModel(
      {final int currentIndex,
      final int itemCount,
      final double iconSize,
      final EdgeInsets iconPadding}) = _$_CustomBottomNavBarModel;

  @override
  int get currentIndex;
  @override
  int get itemCount;
  @override
  double get iconSize;
  @override
  EdgeInsets get iconPadding;
  @override
  @JsonKey(ignore: true)
  _$$_CustomBottomNavBarModelCopyWith<_$_CustomBottomNavBarModel>
      get copyWith => throw _privateConstructorUsedError;
}
