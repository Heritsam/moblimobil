import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/repositories/profile_repository.dart';
import 'change_password_viewmodel.dart';

final oldPasswordNotifier =
    ChangeNotifierProvider((ref) => OldPasswordNotifier(ref.read));

class OldPasswordNotifier extends ChangeNotifier {
  final Reader _read;

  OldPasswordNotifier(this._read);

  String oldPassword = '';
  bool isObscured = true;
  bool isLoading = false;

  void toggleObscure() {
    isObscured = !isObscured;
    notifyListeners();
  }

  Future<void> checkPassword(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      await _read(profileRepository).checkPassword(oldPassword);
      _read(changePasswordViewModel.notifier).sendOldForm();
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }

    isLoading = false;
    notifyListeners();
  }
}
