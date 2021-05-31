import 'package:freezed_annotation/freezed_annotation.dart';

import '../exceptions/network_exceptions.dart';

part 'app_state.freezed.dart';

@freezed
class AppState<T> with _$AppState<T> {
  const factory AppState.initial() = Initial<T>;

  const factory AppState.loading() = Loading<T>;

  const factory AppState.data({required T data}) = Data<T>;

  const factory AppState.error({required NetworkExceptions error}) = Error<T>;
}
