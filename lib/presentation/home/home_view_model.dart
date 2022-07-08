
import 'dart:async';
import 'dart:collection';
import 'package:clean_architecture/data/data_source/result.dart';
import 'package:clean_architecture/domain/model/pixabay_photo.dart';
import 'package:clean_architecture/presentation/home/home_state.dart';
import 'package:clean_architecture/presentation/home/home_ui_event.dart';
import 'package:flutter/material.dart';

import '../../domain/repository/photo_api_repository.dart';

class HomeViewModel with ChangeNotifier {
  final PhotoApiRepository repository;

  HomeState _state = const HomeState([], false);

  HomeViewModel(this.repository);

  final _eventController = StreamController<HomeUIEvent>();
  Stream<HomeUIEvent> get eventStream => _eventController.stream;

  get state => _state;


  Future<void> fetch(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final Result<List<PixabayPhoto>> result = await repository.fetch(query);
    result.when(success: (data) {
      _state = state.copyWith(photos: data);
      notifyListeners();
    }, error: (msg) {
      // print('error message: $msg');
      _eventController.add(HomeUIEvent.showSnackbar(msg));
    });
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

}