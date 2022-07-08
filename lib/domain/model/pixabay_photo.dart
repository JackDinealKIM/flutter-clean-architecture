import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pixabay_photo.g.dart';

part 'pixabay_photo.freezed.dart';

@freezed
class PixabayPhoto with _$PixabayPhoto {
  factory PixabayPhoto({
    required int id,
    required String tags,
    @JsonKey(name: 'previewURL') required String previewUrl,
  }) = _PixabayPhoto;

  factory PixabayPhoto.fromJson(Map<String, dynamic> json) =>
      _$PixabayPhotoFromJson(json);
}
