// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_single_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EditSingleItem {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ImageProvider<Object> get image => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  List<ItemEvent> get events => throw _privateConstructorUsedError;
  List<ItemEvent> get addedEvents => throw _privateConstructorUsedError;
  List<ItemEvent> get deletedEvents => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditSingleItemCopyWith<EditSingleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditSingleItemCopyWith<$Res> {
  factory $EditSingleItemCopyWith(
          EditSingleItem value, $Res Function(EditSingleItem) then) =
      _$EditSingleItemCopyWithImpl<$Res, EditSingleItem>;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      ImageProvider<Object> image,
      bool isFavorite,
      List<ItemEvent> events,
      List<ItemEvent> addedEvents,
      List<ItemEvent> deletedEvents});
}

/// @nodoc
class _$EditSingleItemCopyWithImpl<$Res, $Val extends EditSingleItem>
    implements $EditSingleItemCopyWith<$Res> {
  _$EditSingleItemCopyWithImpl(this._value, this._then);

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
    Object? addedEvents = null,
    Object? deletedEvents = null,
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
      addedEvents: null == addedEvents
          ? _value.addedEvents
          : addedEvents // ignore: cast_nullable_to_non_nullable
              as List<ItemEvent>,
      deletedEvents: null == deletedEvents
          ? _value.deletedEvents
          : deletedEvents // ignore: cast_nullable_to_non_nullable
              as List<ItemEvent>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EditSingleItemCopyWith<$Res>
    implements $EditSingleItemCopyWith<$Res> {
  factory _$$_EditSingleItemCopyWith(
          _$_EditSingleItem value, $Res Function(_$_EditSingleItem) then) =
      __$$_EditSingleItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      ImageProvider<Object> image,
      bool isFavorite,
      List<ItemEvent> events,
      List<ItemEvent> addedEvents,
      List<ItemEvent> deletedEvents});
}

/// @nodoc
class __$$_EditSingleItemCopyWithImpl<$Res>
    extends _$EditSingleItemCopyWithImpl<$Res, _$_EditSingleItem>
    implements _$$_EditSingleItemCopyWith<$Res> {
  __$$_EditSingleItemCopyWithImpl(
      _$_EditSingleItem _value, $Res Function(_$_EditSingleItem) _then)
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
    Object? addedEvents = null,
    Object? deletedEvents = null,
  }) {
    return _then(_$_EditSingleItem(
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
      addedEvents: null == addedEvents
          ? _value._addedEvents
          : addedEvents // ignore: cast_nullable_to_non_nullable
              as List<ItemEvent>,
      deletedEvents: null == deletedEvents
          ? _value._deletedEvents
          : deletedEvents // ignore: cast_nullable_to_non_nullable
              as List<ItemEvent>,
    ));
  }
}

/// @nodoc

class _$_EditSingleItem extends _EditSingleItem {
  _$_EditSingleItem(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.isFavorite,
      required final List<ItemEvent> events,
      final List<ItemEvent> addedEvents = const [],
      final List<ItemEvent> deletedEvents = const []})
      : _events = events,
        _addedEvents = addedEvents,
        _deletedEvents = deletedEvents,
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

  final List<ItemEvent> _addedEvents;
  @override
  @JsonKey()
  List<ItemEvent> get addedEvents {
    if (_addedEvents is EqualUnmodifiableListView) return _addedEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addedEvents);
  }

  final List<ItemEvent> _deletedEvents;
  @override
  @JsonKey()
  List<ItemEvent> get deletedEvents {
    if (_deletedEvents is EqualUnmodifiableListView) return _deletedEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deletedEvents);
  }

  @override
  String toString() {
    return 'EditSingleItem(id: $id, title: $title, description: $description, image: $image, isFavorite: $isFavorite, events: $events, addedEvents: $addedEvents, deletedEvents: $deletedEvents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditSingleItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            const DeepCollectionEquality()
                .equals(other._addedEvents, _addedEvents) &&
            const DeepCollectionEquality()
                .equals(other._deletedEvents, _deletedEvents));
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
      const DeepCollectionEquality().hash(_addedEvents),
      const DeepCollectionEquality().hash(_deletedEvents));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EditSingleItemCopyWith<_$_EditSingleItem> get copyWith =>
      __$$_EditSingleItemCopyWithImpl<_$_EditSingleItem>(this, _$identity);
}

abstract class _EditSingleItem extends EditSingleItem {
  factory _EditSingleItem(
      {required final int id,
      required final String title,
      required final String description,
      required final ImageProvider<Object> image,
      required final bool isFavorite,
      required final List<ItemEvent> events,
      final List<ItemEvent> addedEvents,
      final List<ItemEvent> deletedEvents}) = _$_EditSingleItem;
  _EditSingleItem._() : super._();

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
  List<ItemEvent> get addedEvents;
  @override
  List<ItemEvent> get deletedEvents;
  @override
  @JsonKey(ignore: true)
  _$$_EditSingleItemCopyWith<_$_EditSingleItem> get copyWith =>
      throw _privateConstructorUsedError;
}
