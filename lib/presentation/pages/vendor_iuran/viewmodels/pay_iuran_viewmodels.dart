import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

  // ==
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
    }
  }
}
