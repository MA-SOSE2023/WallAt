// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'single_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SingleItem {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ImageProvider<Object> get image => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  List<ItemEvent> get events => throw _privateConstructorUsedError;
  DateTime? get currentSelectedDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SingleItemCopyWith<SingleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SingleItemCopyWith<$Res> {
  factory $SingleItemCopyWith(
          SingleItem value, $Res Function(SingleItem) then) =
      _$SingleItemCopyWithImpl<$Res, SingleItem>;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      ImageProvider<Object> image,
      bool isFavorite,
      List<ItemEvent> events,
      DateTime? currentSelectedDate});
}

/// @nodoc
class _$SingleItemCopyWithImpl<$Res, $Val extends SingleItem>
    implements $SingleItemCopyWith<$Res> {
  _$SingleItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? image = null,
    Object? isFavorite = null,
    Object? events = null,
    Object? currentSelectedDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as ImageProvider<Object>,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<ItemEvent>,
      currentSelectedDate: freezed == currentSelectedDate
          ? _value.currentSelectedDate
          : currentSelectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SingleItemCopyWith<$Res>
    implements $SingleItemCopyWith<$Res> {
  factory _$$_SingleItemCopyWith(
          _$_SingleItem value, $Res Function(_$_SingleItem) then) =
      __$$_SingleItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      ImageProvider<Object> image,
      bool isFavorite,
      List<ItemEvent> events,
      DateTime? currentSelectedDate});
}

/// @nodoc
class __$$_SingleItemCopyWithImpl<$Res>
    extends _$SingleItemCopyWithImpl<$Res, _$_SingleItem>
    implements _$$_SingleItemCopyWith<$Res> {
  __$$_SingleItemCopyWithImpl(
      _$_SingleItem _value, $Res Function(_$_SingleItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? image = null,
    Object? isFavorite = null,
    Object? events = null,
    Object? currentSelectedDate = freezed,
  }) {
    return _then(_$_SingleItem(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as ImageProvider<Object>,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<ItemEvent>,
      currentSelectedDate: freezed == currentSelectedDate
          ? _value.currentSelectedDate
          : currentSelectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_SingleItem extends _SingleItem {
  _$_SingleItem(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.isFavorite,
      required final List<ItemEvent> events,
      this.currentSelectedDate})
      : _events = events,
        super._();

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  final ImageProvider<Object> image;
  @override
  final bool isFavorite;
  final List<ItemEvent> _events;
  @override
  List<ItemEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  final DateTime? currentSelectedDate;

  @override
  String toString() {
    return 'SingleItem(id: $id, title: $title, description: $description, image: $image, isFavorite: $isFavorite, events: $events, currentSelectedDate: $currentSelectedDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SingleItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            (identical(other.currentSelectedDate, currentSelectedDate) ||
                other.currentSelectedDate == currentSelectedDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      image,
      isFavorite,
      const DeepCollectionEquality().hash(_events),
      currentSelectedDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SingleItemCopyWith<_$_SingleItem> get copyWith =>
      __$$_SingleItemCopyWithImpl<_$_SingleItem>(this, _$identity);
}

abstract class _SingleItem extends SingleItem implements FolderItem {
  factory _SingleItem(
      {required final int id,
      required final String title,
      required final String description,
      required final ImageProvider<Object> image,
      required final bool isFavorite,
      required final List<ItemEvent> events,
      final DateTime? currentSelectedDate}) = _$_SingleItem;
  _SingleItem._() : super._();

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  ImageProvider<Object> get image;
  @override
  bool get isFavorite;
  @override
  List<ItemEvent> get events;
  @override
  DateTime? get currentSelectedDate;
  @override
  @JsonKey(ignore: true)
  _$$_SingleItemCopyWith<_$_SingleItem> get copyWith =>
      throw _privateConstructorUsedError;
}
