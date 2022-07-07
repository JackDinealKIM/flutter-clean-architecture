import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/pixabay.dart';

class PixabayApi {
  final baseUrl = 'https://pixabay.com/api/';
  final key = '28491446-5f9dca4fd56a91a8e5ecfb1ce';

  Future<List<Photo>> fetch(String query) async {
    var url = Uri.parse(
        '$baseUrl?key=$key&q=$query&image_type=photo');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];

    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
