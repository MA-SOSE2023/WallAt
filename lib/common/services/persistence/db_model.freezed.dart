// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'db_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DbModel {
  Future<dynamic>? get db => throw _privateConstructorUsedError;
  FolderDio? get folderDio => throw _privateConstructorUsedError;
  SingleItemDio? get singleItemDio => throw _privateConstructorUsedError;
  ItemEventDio? get eventDio => throw _privateConstructorUsedError;
  int? get rootFolderId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DbModelCopyWith<DbModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DbModelCopyWith<$Res> {
  factory $DbModelCopyWith(DbModel value, $Res Function(DbModel) then) =
      _$DbModelCopyWithImpl<$Res, DbModel>;
  @useResult
  $Res call(
      {Future<dynamic>? db,
      FolderDio? folderDio,
      SingleItemDio? singleItemDio,
      ItemEventDio? eventDio,
      int? rootFolderId});
}

/// @nodoc
class _$DbModelCopyWithImpl<$Res, $Val extends DbModel>
    implements $DbModelCopyWith<$Res> {
  _$DbModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? db = freezed,
    Object? folderDio = freezed,
    Object? singleItemDio = freezed,
    Object? eventDio = freezed,
    Object? rootFolderId = freezed,
  }) {
    return _then(_value.copyWith(
      db: freezed == db
          ? _value.db
          : db // ignore: cast_nullable_to_non_nullable
              as Future<dynamic>?,
      folderDio: freezed == folderDio
          ? _value.folderDio
          : folderDio // ignore: cast_nullable_to_non_nullable
              as FolderDio?,
      singleItemDio: freezed == singleItemDio
          ? _value.singleItemDio
          : singleItemDio // ignore: cast_nullable_to_non_nullable
              as SingleItemDio?,
      eventDio: freezed == eventDio
          ? _value.eventDio
          : eventDio // ignore: cast_nullable_to_non_nullable
              as ItemEventDio?,
      rootFolderId: freezed == rootFolderId
          ? _value.rootFolderId
          : rootFolderId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DbModelCopyWith<$Res> implements $DbModelCopyWith<$Res> {
  factory _$$_DbModelCopyWith(
          _$_DbModel value, $Res Function(_$_DbModel) then) =
      __$$_DbModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Future<dynamic>? db,
      FolderDio? folderDio,
      SingleItemDio? singleItemDio,
      ItemEventDio? eventDio,
      int? rootFolderId});
}

/// @nodoc
class __$$_DbModelCopyWithImpl<$Res>
    extends _$DbModelCopyWithImpl<$Res, _$_DbModel>
    implements _$$_DbModelCopyWith<$Res> {
  __$$_DbModelCopyWithImpl(_$_DbModel _value, $Res Function(_$_DbModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? db = freezed,
    Object? folderDio = freezed,
    Object? singleItemDio = freezed,
    Object? eventDio = freezed,
    Object? rootFolderId = freezed,
  }) {
    return _then(_$_DbModel(
      db: freezed == db
          ? _value.db
          : db // ignore: cast_nullable_to_non_nullable
              as Future<dynamic>?,
      folderDio: freezed == folderDio
          ? _value.folderDio
          : folderDio // ignore: cast_nullable_to_non_nullable
              as FolderDio?,
      singleItemDio: freezed == singleItemDio
          ? _value.singleItemDio
          : singleItemDio // ignore: cast_nullable_to_non_nullable
              as SingleItemDio?,
      eventDio: freezed == eventDio
          ? _value.eventDio
          : eventDio // ignore: cast_nullable_to_non_nullable
              as ItemEventDio?,
      rootFolderId: freezed == rootFolderId
          ? _value.rootFolderId
          : rootFolderId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_DbModel implements _DbModel {
  _$_DbModel(
      {this.db,
      this.folderDio,
      this.singleItemDio,
      this.eventDio,
      this.rootFolderId});

  @override
  final Future<dynamic>? db;
  @override
  final FolderDio? folderDio;
  @override
  final SingleItemDio? singleItemDio;
  @override
  final ItemEventDio? eventDio;
  @override
  final int? rootFolderId;

  @override
  String toString() {
    return 'DbModel(db: $db, folderDio: $folderDio, singleItemDio: $singleItemDio, eventDio: $eventDio, rootFolderId: $rootFolderId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DbModel &&
            (identical(other.db, db) || other.db == db) &&
            (identical(other.folderDio, folderDio) ||
                other.folderDio == folderDio) &&
            (identical(other.singleItemDio, singleItemDio) ||
                other.singleItemDio == singleItemDio) &&
            (identical(other.eventDio, eventDio) ||
                other.eventDio == eventDio) &&
            (identical(other.rootFolderId, rootFolderId) ||
                other.rootFolderId == rootFolderId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, db, folderDio, singleItemDio, eventDio, rootFolderId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DbModelCopyWith<_$_DbModel> get copyWith =>
      __$$_DbModelCopyWithImpl<_$_DbModel>(this, _$identity);
}

abstract class _DbModel implements DbModel {
  factory _DbModel(
      {final Future<dynamic>? db,
      final FolderDio? folderDio,
      final SingleItemDio? singleItemDio,
      final ItemEventDio? eventDio,
      final int? rootFolderId}) = _$_DbModel;

  @override
  Future<dynamic>? get db;
  @override
  FolderDio? get folderDio;
  @override
  SingleItemDio? get singleItemDio;
  @override
  ItemEventDio? get eventDio;
  @override
  int? get rootFolderId;
  @override
  @JsonKey(ignore: true)
  _$$_DbModelCopyWith<_$_DbModel> get copyWith =>
      throw _privateConstructorUsedError;
}
