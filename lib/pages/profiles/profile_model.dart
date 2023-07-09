import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required int id,
    required String name,
    required int selectedImageIndex,
  }) = _ProfileModel;

  factory ProfileModel.defaultPlaceholder() => const ProfileModel(
        id: 0,
        name: 'Global view',
        selectedImageIndex: -1,
      );
}
