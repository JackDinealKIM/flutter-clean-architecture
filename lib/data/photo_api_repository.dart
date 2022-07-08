
import 'package:clean_architecture/model/pixabay_photo.dart';
import 'package:http/http.dart' as http;

abstract class PhotoApiRepository {
  Future<List<PixabayPhoto>> fetch(String query, {http.Client? client});
}