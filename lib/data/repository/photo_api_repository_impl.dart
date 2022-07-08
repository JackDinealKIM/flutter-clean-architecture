import 'package:clean_architecture/data/data_source/pixabay_api.dart';
import 'package:clean_architecture/data/data_source/result.dart';
import 'package:clean_architecture/domain/repository/photo_api_repository.dart';
import 'package:clean_architecture/domain/model/pixabay_photo.dart';

class PhotoApiRepositoryImpl extends PhotoApiRepository {
  final PixabayApi api;

  PhotoApiRepositoryImpl(this.api);

  @override
  Future<Result<List<PixabayPhoto>>> fetch(String query) async {
    // client ??= http.Client();
    final Result<Iterable> result = await api.fetch(query);
    return result.when(success: (data) {
      return Result.success(data.map((e) => PixabayPhoto.fromJson(e)).toList());
    }, error: (message) {
      return Result.error(message);
    });
  }
}
