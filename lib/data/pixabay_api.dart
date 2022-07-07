import 'dart:convert';
import 'package:clean_architecture/data/photo_api_repository.dart';
import 'package:http/http.dart' as http;

import '../model/pixabay.dart';

class PixabayApi extends PhotoApiRepository {
  static const baseUrl = 'https://pixabay.com/api/';
  static const key = '28491446-5f9dca4fd56a91a8e5ecfb1ce';

  @override
  Future<List<Photo>> fetch(String query, {http.Client? client}) async {
    client ??= http.Client();
    var url = Uri.parse(
        '$baseUrl?key=$key&q=$query&image_type=photo');
    var response = await client.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];

    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
