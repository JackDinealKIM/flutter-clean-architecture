
import 'dart:math';

import 'package:clean_architecture/data/data_source/result.dart';
import 'package:clean_architecture/domain/model/pixabay_photo.dart';
import 'package:clean_architecture/domain/repository/photo_api_repository.dart';

class GetPhotosUseCase {

  final PhotoApiRepository repository;

  GetPhotosUseCase(this.repository);

  Future<Result<List<PixabayPhoto>>> call(String query) async {
    final Result<List<PixabayPhoto>> result = await repository.fetch(query);
    return result.when(success: (data) {
      return Result.success(data.sublist(0, min(3, data.length)));
    }, error: (msg) {
      return Result.error(msg);
    });
  }
}