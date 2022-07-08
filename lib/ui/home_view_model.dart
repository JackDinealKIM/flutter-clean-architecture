
import 'dart:async';
import 'dart:collection';
import 'package:clean_architecture/model/pixabay_photo.dart';
import 'package:flutter/material.dart';

import '../data/photo_api_repository.dart';

class HomeViewModel with ChangeNotifier {
  final PhotoApiRepository repository;

  List<PixabayPhoto> _photos = [];

  HomeViewModel(this.repository);

  UnmodifiableListView<PixabayPhoto> get photos => UnmodifiableListView(_photos);

  Future<void> fetch(String query) async {
    final result = await repository.fetch(query);
    _photos = result;
    notifyListeners();
  }

}