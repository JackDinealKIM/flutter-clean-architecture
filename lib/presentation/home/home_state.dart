import 'package:clean_architecture/domain/model/pixabay_photo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState(List<PixabayPhoto> photos, bool isLoading) = _HomeState;
}

/*
class HomeState {
  final List<PixabayPhoto> photos;
  final bool isLoading;

  HomeState(this.photos, this.isLoading);

  HomeState copy({List<PixabayPhoto>? photos, bool? isLoading}) {
    return HomeState(
      photos ??= this.photos,
      isLoading ??= this.isLoading,
    );
  }
}
*/