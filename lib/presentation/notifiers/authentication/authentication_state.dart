part of 'authentication_notifier.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;
  const factory AuthenticationState.unauthenticated() = _Unauthenticated;
  const factory AuthenticationState.authenticated() = _Authenticated;
}
