
import 'dart:async';
import 'package:clean_architecture/model/pixabay_photo.dart';

import '../data/photo_api_repository.dart';

class HomeViewModel {
  final PhotoApiRepository repository;

  HomeViewModel(this.repository);

  final _photoStreamController = StreamController<List<PixabayPhoto>>()..add([]);
  Stream<List<PixabayPhoto>> get photoStream => _photoStreamController.stream;


  Future<void> fetch(String query) async {
    final result = await repository.fetch(query);
    _photoStreamController.add(result);
  }

}