import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/repositories/profile_repository.dart';

final forgotPassword2ViewModel =
    ChangeNotifierProvider<ForgotPassword2ViewModel>((ref) {
  return ForgotPassword2ViewModel(ref.read);
});

class ForgotPassword2ViewModel extends ChangeNotifier {
  final Reader _read;

  ForgotPassword2ViewModel(this._read);

  String newPassword = '';
  bool isObscured = true;
  bool isLoading = false;

  Future<void> submit(BuildContext context, int userId) async {
    isLoading = true;
    notifyListeners();

    try {
      await _read(profileRepository).changeForgotPassword(userId, newPassword);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));

      Navigator.popUntil(context, ModalRoute.withName('/login'));
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }

    isLoading = false;
    notifyListeners();
  }
}
