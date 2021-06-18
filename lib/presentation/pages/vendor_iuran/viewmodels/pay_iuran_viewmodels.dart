import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moblimobil/infrastructures/params/iuran/pay_iuran_params.dart';
import 'package:moblimobil/infrastructures/repositories/iuran_repository.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/bank/bank.dart';
import '../../../../infrastructures/repositories/bank_repository.dart';

final payIuranViewModels = ChangeNotifierProvider<PayIuranViewModels>((ref) {
  return PayIuranViewModels(ref.read);
});

class PayIuranViewModels extends ChangeNotifier {
  final Reader _read;

  PayIuranViewModels(this._read);

  late AppState<List<Bank>> bankState;

  String fullname = '';
  Bank? bankId;
  String accountNumber = '';
  String nominal = '';
  String type = '3_month';
  File? file;

  bool isLoading = false;

  void initialize() {
    fullname = '';
    bankId = null;
    accountNumber = '';
    nominal = '';
    type = '3_month';
    file = null;

    bankState = AppState.initial();

    fetchBanks();

    notifyListeners();
  }

  Future<void> fetchBanks() async {
    try {
      final banks = await _read(bankRepository).banks();

      bankState = AppState.data(data: banks);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      bankState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> submit(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      await _read(iuranRepository).pay(
        PayIuranParams(
          fullname: fullname,
          accountNumber: accountNumber,
          nominal: nominal,
          type: type,
          bankId: bankId!,
          file: file!,
        ),
      );

      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }

    isLoading = false;
    notifyListeners();
  }

  void changeType(String value) {
    type = value;
    notifyListeners();
  }

  void chooseBank(Bank? value) {
    bankId = value!;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.getImage(source: ImageSource.camera);

    if (picked != null) {
      file = File(picked.path);
      notifyListeners();
    }
  }

  void peekImage(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.file(file!),
        ),
      ),
    );
  }
}
