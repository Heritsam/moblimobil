import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/preferences_key.dart';
import '../../../providers.dart';

part 'authentication_notifier.freezed.dart';
part 'authentication_state.dart';

final authenticationNotifier =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>(
  (ref) {
    final preferences = ref.watch(sharedPreferences);

    return AuthenticationNotifier(preferences);
  },
);

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  AuthenticationNotifier(this._preferences)
      : super(AuthenticationState.unauthenticated());

  final SharedPreferences _preferences;

  void checkStatus() {
    if (_preferences.containsKey(PreferencesKey.tokenKey)) {
      state = AuthenticationState.authenticated();
    } else {
      state = AuthenticationState.unauthenticated();
    }
  }

  void logout() {
    _preferences.remove(PreferencesKey.tokenKey);
    checkStatus();
  }
}
