import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/repositories/profile_repository.dart';
import 'change_password_viewmodel.dart';

final newPasswordNotifier =
    ChangeNotifierProvider((ref) => NewPasswordNotifier(ref.read));

class NewPasswordNotifier extends ChangeNotifier {
  final Reader _read;

  NewPasswordNotifier(this._read);

  String newPassword = '';
  bool isObscured = true;
  bool isLoading = false;

  void toggleObscure() {
    isObscured = !isObscured;
    notifyListeners();
  }

  Future<void> updatePassword(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      await _read(profileRepository).updatePassword(newPassword);
      _read(changePasswordViewModel.notifier).sendNewForm();
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }

    isLoading = false;
    notifyListeners();
  }
}
