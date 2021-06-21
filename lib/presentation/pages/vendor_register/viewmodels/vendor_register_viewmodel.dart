import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moblimobil/presentation/pages/account/viewmodels/account_user_notifier.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/repositories/vendor_repository.dart';

final vendorRegisterViewModel =
    ChangeNotifierProvider<VendorRegisterViewModel>((ref) {
  return VendorRegisterViewModel(ref.read);
});

class VendorRegisterViewModel extends ChangeNotifier {
  final Reader _read;

  VendorRegisterViewModel(this._read);

  bool isLoading = false;

  Future<void> submit(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      await _read(vendorRepository).submit();

      Navigator.popUntil(context, ModalRoute.withName('/home'));

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));

      _read(accountUserNotifier).fetchUser();
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }

    isLoading = false;
    notifyListeners();
  }
}
