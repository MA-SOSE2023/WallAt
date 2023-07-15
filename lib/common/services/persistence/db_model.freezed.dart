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
  Future<Db>? get db => throw _privateConstructorUsedError;
  FolderDao? get folderDao => throw _privateConstructorUsedError;
  SingleItemDao? get singleItemDao => throw _privateConstructorUsedError;
  ItemEventDao? get eventDao => throw _privateConstructorUsedError;
  ProfileDao? get profileDao => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DbModelCopyWith<DbModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DbModelCopyWith<$Res> {
  factory $DbModelCopyWith(DbModel value, $Res Function(DbModel) then) =
      _$DbModelCopyWithImpl<$Res, DbModel>;
  @useResult
  $Res call(
      {Future<Db>? db,
      FolderDao? folderDao,
      SingleItemDao? singleItemDao,
      ItemEventDao? eventDao,
      ProfileDao? profileDao});
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
    Object? folderDao = freezed,
    Object? singleItemDao = freezed,
    Object? eventDao = freezed,
    Object? profileDao = freezed,
  }) {
    return _then(_value.copyWith(
      db: freezed == db
          ? _value.db
          : db // ignore: cast_nullable_to_non_nullable
              as Future<Db>?,
      folderDao: freezed == folderDao
          ? _value.folderDao
          : folderDao // ignore: cast_nullable_to_non_nullable
              as FolderDao?,
      singleItemDao: freezed == singleItemDao
          ? _value.singleItemDao
          : singleItemDao // ignore: cast_nullable_to_non_nullable
              as SingleItemDao?,
      eventDao: freezed == eventDao
          ? _value.eventDao
          : eventDao // ignore: cast_nullable_to_non_nullable
              as ItemEventDao?,
      profileDao: freezed == profileDao
          ? _value.profileDao
          : profileDao // ignore: cast_nullable_to_non_nullable
              as ProfileDao?,
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
      {Future<Db>? db,
      FolderDao? folderDao,
      SingleItemDao? singleItemDao,
      ItemEventDao? eventDao,
      ProfileDao? profileDao});
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
    Object? folderDao = freezed,
    Object? singleItemDao = freezed,
    Object? eventDao = freezed,
    Object? profileDao = freezed,
  }) {
    return _then(_$_DbModel(
      db: freezed == db
          ? _value.db
          : db // ignore: cast_nullable_to_non_nullable
              as Future<Db>?,
      folderDao: freezed == folderDao
          ? _value.folderDao
          : folderDao // ignore: cast_nullable_to_non_nullable
              as FolderDao?,
      singleItemDao: freezed == singleItemDao
          ? _value.singleItemDao
          : singleItemDao // ignore: cast_nullable_to_non_nullable
              as SingleItemDao?,
      eventDao: freezed == eventDao
          ? _value.eventDao
          : eventDao // ignore: cast_nullable_to_non_nullable
              as ItemEventDao?,
      profileDao: freezed == profileDao
          ? _value.profileDao
          : profileDao // ignore: cast_nullable_to_non_nullable
              as ProfileDao?,
    ));
  }
}

/// @nodoc

class _$_DbModel implements _DbModel {
  _$_DbModel(
      {this.db,
      this.folderDao,
      this.singleItemDao,
      this.eventDao,
      this.profileDao});

  @override
  final Future<Db>? db;
  @override
  final FolderDao? folderDao;
  @override
  final SingleItemDao? singleItemDao;
  @override
  final ItemEventDao? eventDao;
  @override
  final ProfileDao? profileDao;

  @override
  String toString() {
    return 'DbModel(db: $db, folderDao: $folderDao, singleItemDao: $singleItemDao, eventDao: $eventDao, profileDao: $profileDao)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DbModel &&
            (identical(other.db, db) || other.db == db) &&
            (identical(other.folderDao, folderDao) ||
                other.folderDao == folderDao) &&
            (identical(other.singleItemDao, singleItemDao) ||
                other.singleItemDao == singleItemDao) &&
            (identical(other.eventDao, eventDao) ||
                other.eventDao == eventDao) &&
            (identical(other.profileDao, profileDao) ||
                other.profileDao == profileDao));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, db, folderDao, singleItemDao, eventDao, profileDao);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DbModelCopyWith<_$_DbModel> get copyWith =>
      __$$_DbModelCopyWithImpl<_$_DbModel>(this, _$identity);
}

abstract class _DbModel implements DbModel {
  factory _DbModel(
      {final Future<Db>? db,
      final FolderDao? folderDao,
      final SingleItemDao? singleItemDao,
      final ItemEventDao? eventDao,
      final ProfileDao? profileDao}) = _$_DbModel;

  @override
  Future<Db>? get db;
  @override
  FolderDao? get folderDao;
  @override
  SingleItemDao? get singleItemDao;
  @override
  ItemEventDao? get eventDao;
  @override
  ProfileDao? get profileDao;
  @override
  @JsonKey(ignore: true)
  _$$_DbModelCopyWith<_$_DbModel> get copyWith =>
      throw _privateConstructorUsedError;
}
