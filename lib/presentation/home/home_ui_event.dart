import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_ui_event.freezed.dart';

@freezed
abstract class HomeUIEvent<T> with _$HomeUIEvent<T> {
  const factory HomeUIEvent.showSnackbar(String message) = ShowSnackBar;
}
