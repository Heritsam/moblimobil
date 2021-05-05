import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModel =
    ChangeNotifierProvider((ref) => LoginViewModel(ref.read));

class LoginViewModel extends ChangeNotifier {
  late final Reader _reader;

  LoginViewModel(this._reader);

  bool isObscured = true;
  bool rememberMe = false;

  void toggleObscure() {
    isObscured = !isObscured;
    notifyListeners();
  }

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  void navigateToForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, '/forgot-password');
  }

  void login(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }
}
