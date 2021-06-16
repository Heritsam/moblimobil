import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/repositories/profile_repository.dart';

final forgotPasswordViewModel =
    ChangeNotifierProvider<ForgotPasswordViewModel>((ref) {
  return ForgotPasswordViewModel(ref.read);
});

class ForgotPasswordViewModel extends ChangeNotifier {
  final Reader _read;

  ForgotPasswordViewModel(this._read);

  String email = '';
  bool isLoading = false;

  Future<void> submit(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      await _read(profileRepository).forgotPassword(email);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Success. Check your email inbox')));

      Navigator.popUntil(context, ModalRoute.withName('/login'));
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }

    isLoading = false;
    notifyListeners();
  }
}
