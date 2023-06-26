// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TakePictureModel {
  List<String> get pictures => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TakePictureModelCopyWith<TakePictureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TakePictureModelCopyWith<$Res> {
  factory $TakePictureModelCopyWith(
          TakePictureModel value, $Res Function(TakePictureModel) then) =
      _$TakePictureModelCopyWithImpl<$Res, TakePictureModel>;
  @useResult
  $Res call({List<String> pictures});
}

/// @nodoc
class _$TakePictureModelCopyWithImpl<$Res, $Val extends TakePictureModel>
    implements $TakePictureModelCopyWith<$Res> {
  _$TakePictureModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pictures = null,
  }) {
    return _then(_value.copyWith(
      pictures: null == pictures
          ? _value.pictures
          : pictures // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TakePictureModelCopyWith<$Res>
    implements $TakePictureModelCopyWith<$Res> {
  factory _$$_TakePictureModelCopyWith(
          _$_TakePictureModel value, $Res Function(_$_TakePictureModel) then) =
      __$$_TakePictureModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> pictures});
}

/// @nodoc
class __$$_TakePictureModelCopyWithImpl<$Res>
    extends _$TakePictureModelCopyWithImpl<$Res, _$_TakePictureModel>
    implements _$$_TakePictureModelCopyWith<$Res> {
  __$$_TakePictureModelCopyWithImpl(
      _$_TakePictureModel _value, $Res Function(_$_TakePictureModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pictures = null,
  }) {
    return _then(_$_TakePictureModel(
      pictures: null == pictures
          ? _value._pictures
          : pictures // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_TakePictureModel
    with DiagnosticableTreeMixin
    implements _TakePictureModel {
  const _$_TakePictureModel({required final List<String> pictures})
      : _pictures = pictures;

  final List<String> _pictures;
  @override
  List<String> get pictures {
    if (_pictures is EqualUnmodifiableListView) return _pictures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pictures);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TakePictureModel(pictures: $pictures)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TakePictureModel'))
      ..add(DiagnosticsProperty('pictures', pictures));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TakePictureModel &&
            const DeepCollectionEquality().equals(other._pictures, _pictures));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_pictures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TakePictureModelCopyWith<_$_TakePictureModel> get copyWith =>
      __$$_TakePictureModelCopyWithImpl<_$_TakePictureModel>(this, _$identity);
}

abstract class _TakePictureModel implements TakePictureModel {
  const factory _TakePictureModel({required final List<String> pictures}) =
      _$_TakePictureModel;

  @override
  List<String> get pictures;
  @override
  @JsonKey(ignore: true)
  _$$_TakePictureModelCopyWith<_$_TakePictureModel> get copyWith =>
      throw _privateConstructorUsedError;
}
