import 'dart:convert';
import 'dart:io';

import 'package:clean_architecture/data/data_source/result.dart';
import 'package:clean_architecture/domain/model/pixabay_photo.dart';
import 'package:http/http.dart' as http;

class PixabayApi {
  static const baseUrl = 'https://pixabay.com/api/';
  static const key = '28491446-5f9dca4fd56a91a8e5ecfb1ce';

  final http.Client client;

  PixabayApi(this.client);

  Future<Result<Iterable>> fetch(String query) async {
    try {
      var url = Uri.parse(
          '$baseUrl?key=$key&q=$query&image_type=photo');
      var response = await client.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      Iterable hits = jsonResponse['hits'];
      return Result.success(hits);
    } catch(e) {
      return Result.error(e.toString());
    }
  }
}