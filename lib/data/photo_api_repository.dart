
import '../model/pixabay.dart';
import 'package:http/http.dart' as http;

abstract class PhotoApiRepository {
  Future<List<Photo>> fetch(String query, {http.Client? client});
}