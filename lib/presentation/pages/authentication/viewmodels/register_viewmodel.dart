import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/repositories/authentication_repository.dart';

final registerViewModel =
    ChangeNotifierProvider((ref) => RegisterViewModel(ref.read));

class RegisterViewModel extends ChangeNotifier {
  final Reader _read;

  RegisterViewModel(this._read);

  bool isLoading = false;
  bool isObscured = true;

  String fullname = '';
  String phone = '';
  String email = '';
  String password = '';

  void toggleObscure() {
    isObscured = !isObscured;
    notifyListeners();
  }

  void register(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      await _read(authenticationRepository).register(
        fullname: fullname,
        phone: phone,
        email: email,
        password: password,
      );
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }

    isLoading = false;
    notifyListeners();
  }
}
