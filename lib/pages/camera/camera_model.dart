import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_model.freezed.dart';

@freezed
class TakePictureModel with _$TakePictureModel {
  const factory TakePictureModel({
    required List<String> pictures,
  }) = _TakePictureModel;
}
