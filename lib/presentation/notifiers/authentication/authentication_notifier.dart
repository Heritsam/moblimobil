import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_notifier.freezed.dart';
part 'authentication_state.dart';

final authenticationNotifier =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>(
        (ref) => AuthenticationNotifier());

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  AuthenticationNotifier() : super(AuthenticationState.initial());

  void initialize() async {
    await Future.delayed(Duration(seconds: 1));
    
    state = AuthenticationState.unauthenticated();
  }

  void login() {
    state = AuthenticationState.authenticated();
  }

  void logout() {
    state = AuthenticationState.unauthenticated();
  }
}
