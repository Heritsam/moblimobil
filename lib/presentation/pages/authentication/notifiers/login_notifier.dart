import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginNotifier =
    ChangeNotifierProvider((ref) => LoginNotifier(ref.read));

class LoginNotifier extends ChangeNotifier {
  late final Reader _reader;

  LoginNotifier(this._reader);

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

  void navigateToHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }
}
