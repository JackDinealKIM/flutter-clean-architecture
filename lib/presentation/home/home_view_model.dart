
import 'dart:async';
import 'dart:collection';
import 'package:clean_architecture/data/data_source/result.dart';
import 'package:clean_architecture/domain/model/pixabay_photo.dart';
import 'package:clean_architecture/presentation/home/home_ui_event.dart';
import 'package:flutter/material.dart';

import '../../domain/repository/photo_api_repository.dart';

class HomeViewModel with ChangeNotifier {
  final PhotoApiRepository repository;

  List<PixabayPhoto> _photos = [];

  HomeViewModel(this.repository);

  UnmodifiableListView<PixabayPhoto> get photos => UnmodifiableListView(_photos);

  final _eventController = StreamController<HomeUIEvent>();
  Stream<HomeUIEvent> get eventStream => _eventController.stream;

  Future<void> fetch(String query) async {
    final Result<List<PixabayPhoto>> result = await repository.fetch(query);
    result.when(success: (data) {
      _photos = data;
      notifyListeners();
    }, error: (msg) {
      // print('error message: $msg');
      _eventController.add(HomeUIEvent.showSnackbar(msg));
    });
  }

}