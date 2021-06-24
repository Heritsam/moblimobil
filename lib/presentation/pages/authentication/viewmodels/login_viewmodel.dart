import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/models/auth/email_not_verified.dart';
import '../../../../infrastructures/repositories/authentication_repository.dart';
import '../../../../infrastructures/repositories/onesignal_repository.dart';
import '../../../notifiers/authentication/authentication_notifier.dart';
import '../otp_page.dart';

final loginViewModel =
    ChangeNotifierProvider((ref) => LoginViewModel(ref.read));

class LoginViewModel extends ChangeNotifier {
  final Reader _read;

  LoginViewModel(this._read);

  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  bool isLoading = false;
  bool isObscured = true;
  bool rememberMe = false;

  String email = '';
  String password = '';

  void toggleObscure() {
    isObscured = !isObscured;
    notifyListeners();
  }

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  void login(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final user = await _read(authenticationRepository).login(
        email: email,
        password: password,
      );

      _read(authenticationNotifier.notifier).checkStatus();
      _read(onesignalRepository).setExternalUserId(user.data.id);

      // reset password visibility
      isObscured = true;

      Navigator.popUntil(context, ModalRoute.withName('/home'));
    } on NetworkExceptions catch (e) {
      e.maybeWhen(
        defaultError: (message, response) {
          if (e.message == 'email_not_verified') {
            final args = EmailNotVerified.fromJson(response!.data);
            Navigator.pushNamed(context, '/otp', arguments: OtpArgs(args));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
        },
        orElse: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
        },
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
