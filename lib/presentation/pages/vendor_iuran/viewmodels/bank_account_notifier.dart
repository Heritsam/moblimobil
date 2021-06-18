import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/bank/bank_account.dart';
import '../../../../infrastructures/repositories/bank_repository.dart';

final bankAccountNotifier = ChangeNotifierProvider<BankAccountNotifier>((ref) {
  return BankAccountNotifier(ref.read);
});

class BankAccountNotifier extends ChangeNotifier {
  final Reader _read;

  BankAccountNotifier(this._read) {
    fetch();
  }

  AppState<List<BankAccount>> bankState = AppState.initial();

  Future<void> fetch() async {
    bankState = AppState.loading();
    notifyListeners();
    
    try {
      final items = await _read(bankRepository).bankAccounts();

      bankState = AppState.data(data: items);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      bankState = AppState.error(message: e.message);
      notifyListeners();
    }
  }
}