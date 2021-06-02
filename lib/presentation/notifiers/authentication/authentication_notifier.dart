import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/preferences_key.dart';
import '../../../infrastructures/repositories/onesignal_repository.dart';
import '../../../providers.dart';

part 'authentication_notifier.freezed.dart';
part 'authentication_state.dart';

final authenticationNotifier =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>(
  (ref) {
    final preferences = ref.watch(sharedPreferences);

    return AuthenticationNotifier(ref.read, preferences);
  },
);

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  AuthenticationNotifier(this._read, this._preferences)
      : super(AuthenticationState.unauthenticated());

  final Reader _read;
  final SharedPreferences _preferences;

  void checkStatus() {
    if (_preferences.containsKey(PreferencesKey.tokenKey)) {
      state = AuthenticationState.authenticated();
    } else {
      state = AuthenticationState.unauthenticated();
    }
  }

  Future<void> logout() async {
    try {
      _preferences.remove(PreferencesKey.tokenKey);
      checkStatus();
      _read(onesignalRepository).removeExternalUserId();
    } catch (e) {
      logout();
    }
  }
}
