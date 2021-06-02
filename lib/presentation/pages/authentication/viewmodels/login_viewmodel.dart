import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moblimobil/infrastructures/models/auth/email_not_verified.dart';
import 'package:moblimobil/presentation/pages/authentication/otp_page.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/repositories/authentication_repository.dart';
import '../../../../infrastructures/repositories/onesignal_repository.dart';
import '../../../notifiers/authentication/authentication_notifier.dart';

final loginViewModel =
    ChangeNotifierProvider((ref) => LoginViewModel(ref.read));

class LoginViewModel extends ChangeNotifier {
  final Reader _read;

  LoginViewModel(this._read);

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

      Navigator.popUntil(context, ModalRoute.withName('/home'));
    } on NetworkExceptions catch (e) {
      e.maybeWhen(
        defaultError: (message, response) {
          if (e.message == 'email_not_verified') {
            final args = EmailNotVerified.fromJson(response!.data);
            Navigator.pushNamed(context, '/otp', arguments: OtpArgs(args));
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
}
