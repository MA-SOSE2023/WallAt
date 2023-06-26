// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ItemEvent {
  int get id => throw _privateConstructorUsedError;
  Event get event => throw _privateConstructorUsedError;
  int get parentId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ItemEventCopyWith<ItemEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemEventCopyWith<$Res> {
  factory $ItemEventCopyWith(ItemEvent value, $Res Function(ItemEvent) then) =
      _$ItemEventCopyWithImpl<$Res, ItemEvent>;
  @useResult
  $Res call({int id, Event event, int parentId});
}

/// @nodoc
class _$ItemEventCopyWithImpl<$Res, $Val extends ItemEvent>
    implements $ItemEventCopyWith<$Res> {
  _$ItemEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? event = null,
    Object? parentId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Event,
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ItemEventCopyWith<$Res> implements $ItemEventCopyWith<$Res> {
  factory _$$_ItemEventCopyWith(
          _$_ItemEvent value, $Res Function(_$_ItemEvent) then) =
      __$$_ItemEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, Event event, int parentId});
}

/// @nodoc
class __$$_ItemEventCopyWithImpl<$Res>
    extends _$ItemEventCopyWithImpl<$Res, _$_ItemEvent>
    implements _$$_ItemEventCopyWith<$Res> {
  __$$_ItemEventCopyWithImpl(
      _$_ItemEvent _value, $Res Function(_$_ItemEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? event = null,
    Object? parentId = null,
  }) {
    return _then(_$_ItemEvent(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Event,
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ItemEvent implements _ItemEvent {
  const _$_ItemEvent(
      {required this.id, required this.event, required this.parentId});

  @override
  final int id;
  @override
  final Event event;
  @override
  final int parentId;

  @override
  String toString() {
    return 'ItemEvent(id: $id, event: $event, parentId: $parentId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ItemEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, event, parentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ItemEventCopyWith<_$_ItemEvent> get copyWith =>
      __$$_ItemEventCopyWithImpl<_$_ItemEvent>(this, _$identity);
}

abstract class _ItemEvent implements ItemEvent {
  const factory _ItemEvent(
      {required final int id,
      required final Event event,
      required final int parentId}) = _$_ItemEvent;

  @override
  int get id;
  @override
  Event get event;
  @override
  int get parentId;
  @override
  @JsonKey(ignore: true)
  _$$_ItemEventCopyWith<_$_ItemEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
