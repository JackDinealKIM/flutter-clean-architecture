import 'package:clean_architecture/domain/model/pixabay_photo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pixabay.g.dart';
part 'pixabay.freezed.dart';

@freezed
class Pixabay with _$Pixabay {
  const factory Pixabay({required int total, required int totalHits, required List<PixabayPhoto> hits}) = _Pixabay;

  factory Pixabay.fromJson(Map<String, dynamic> json) =>
      _$PixabayFromJson(json);
}
