import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/product/product.dart';
import '../../../../infrastructures/repositories/product_repository.dart';

final carsDetailViewModel = ChangeNotifierProvider<CarsDetailViewModel>((ref) {
  return CarsDetailViewModel(ref.read);
});

class CarsDetailViewModel extends ChangeNotifier {
  final Reader _read;

  CarsDetailViewModel(this._read);

  AppState<Product> productState = AppState.initial();

  Future<void> fetch(int id) async {
    productState = AppState.loading();
    notifyListeners();

    try {
      final cars = await _read(productRepository).detail(id);

      productState = AppState.data(data: cars);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      productState = AppState.error(message: e.message);
      notifyListeners();
    }
  }
}
