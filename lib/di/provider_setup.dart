import 'dart:js';

import 'package:clean_architecture/data/data_source/pixabay_api.dart';
import 'package:clean_architecture/data/repository/photo_api_repository_impl.dart';
import 'package:clean_architecture/domain/use_case/get_photos_use_case.dart';
import 'package:clean_architecture/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:http/http.dart' as http;

// 1. Provider 객체
List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

// 2. 독립적인 객체
List<SingleChildWidget> independentModels = [
  Provider<http.Client>(
    create: (context) => http.Client(),
  )
];

// 3. 2번의 의존성있는 객체
List<SingleChildWidget> dependentModels = [
  ProxyProvider<http.Client, PixabayApi>(
    update: (context, client, _) => PixabayApi(client),
  ),
  ProxyProvider<PixabayApi, PhotoApiRepositoryImpl>(
    update: (context, api, _) => PhotoApiRepositoryImpl(api),
  ),
  ProxyProvider<PhotoApiRepositoryImpl, GetPhotosUseCase>(
    update: (context, repository, _) => GetPhotosUseCase(repository),
  ),
];

// 4. viewModels
List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(context.read<GetPhotosUseCase>())),
];
