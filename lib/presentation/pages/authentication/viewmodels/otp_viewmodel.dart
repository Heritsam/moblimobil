import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/repositories/authentication_repository.dart';
import '../../../../infrastructures/repositories/onesignal_repository.dart';
import '../../../notifiers/authentication/authentication_notifier.dart';

final otpViewModel = ChangeNotifierProvider((ref) => OtpViewModel(ref.read));

class OtpViewModel extends ChangeNotifier {
  final Reader _read;

  OtpViewModel(this._read);

  bool isLoading = false;
  String token = '';
  int userId = 0;
  String password = '';

  Future<void> checkToken(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    
    try {
      final user = await _read(authenticationRepository).checkToken(
        token: token,
        userId: userId,
        password: password,
      );

      _read(authenticationNotifier.notifier).checkStatus();
      _read(onesignalRepository).setExternalUserId(user.data.id);

      Navigator.popUntil(context, ModalRoute.withName('/home'));
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }

    isLoading = false;
    notifyListeners();
  }
}
