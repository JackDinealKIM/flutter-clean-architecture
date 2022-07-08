
import 'package:clean_architecture/data/data_source/result.dart';
import 'package:clean_architecture/domain/model/pixabay_photo.dart';

abstract class PhotoApiRepository {
  Future<Result<List<PixabayPhoto>>> fetch(String query);
}