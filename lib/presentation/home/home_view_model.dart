
import 'dart:async';
import 'dart:collection';
import 'package:clean_architecture/data/data_source/result.dart';
import 'package:clean_architecture/domain/model/pixabay_photo.dart';
import 'package:clean_architecture/domain/use_case/get_photos_use_case.dart';
import 'package:clean_architecture/presentation/home/home_state.dart';
import 'package:clean_architecture/presentation/home/home_ui_event.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  final GetPhotosUseCase getPhotosUseCase;

  HomeState _state = const HomeState([], false);

  HomeViewModel(this.getPhotosUseCase);

  final _eventController = StreamController<HomeUIEvent>();
  Stream<HomeUIEvent> get eventStream => _eventController.stream;

  get state => _state;


  Future<void> fetch(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    // final Result<List<PixabayPhoto>> result = await getPhotosUseCase.call(query);
    // call은 생략이 가능하다
    final Result<List<PixabayPhoto>> result = await getPhotosUseCase(query);
    result.when(success: (data) {
      _state = state.copyWith(photos: data);
      notifyListeners();
    }, error: (msg) {
      _eventController.add(HomeUIEvent.showSnackbar(msg));
    });
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

}