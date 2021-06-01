import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/profile/user.dart';
import '../../../../infrastructures/repositories/profile_repository.dart';

final accountUserNotifier = ChangeNotifierProvider<AccountUserNotifier>((ref) {
  return AccountUserNotifier(ref.read);
});

class AccountUserNotifier extends ChangeNotifier {
  final Reader _read;

  AccountUserNotifier(this._read) {
    fetchUser();
  }

  AppState<User> userState = AppState.loading();

  Future<void> fetchUser() async {
    userState = AppState.loading();
    notifyListeners();
    
    try {
      final user = await _read(profileRepository).me();

      userState = AppState.data(data: user);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      userState = AppState.error(message: e.message);
      notifyListeners();
    }
  }
}
