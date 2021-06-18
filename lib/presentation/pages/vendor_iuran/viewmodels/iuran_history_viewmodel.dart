import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/iuran/iuran.dart';
import '../../../../infrastructures/repositories/iuran_repository.dart';

final iuranHistoryViewModel = ChangeNotifierProvider<IuranHistoryViewModel>((ref) {
  return IuranHistoryViewModel(ref.read);
});

class IuranHistoryViewModel extends ChangeNotifier {
  final Reader _read;

  IuranHistoryViewModel(this._read);

  AppState<List<Iuran>> iuranState = AppState.initial();

  Future<void> fetch() async {
    iuranState = AppState.loading();
    notifyListeners();
    
    try {
      final fees = await _read(iuranRepository).index();

      iuranState = AppState.data(data: fees.data);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      iuranState = AppState.error(message: e.message);
    }
  }
}