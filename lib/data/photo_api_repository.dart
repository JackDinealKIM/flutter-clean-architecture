
import '../model/pixabay.dart';

abstract class PhotoApiRepository {
  Future<List<Photo>> fetch(String query);
}