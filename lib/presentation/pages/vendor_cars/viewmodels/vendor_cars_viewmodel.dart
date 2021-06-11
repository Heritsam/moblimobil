import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/product/product.dart';
import '../../../../infrastructures/repositories/product_repository.dart';

final vendorCarsViewModel = ChangeNotifierProvider<VendorCarsViewModel>((ref) {
  return VendorCarsViewModel(ref.read);
});

class VendorCarsViewModel extends ChangeNotifier {
  final Reader _read;

  VendorCarsViewModel(this._read) {
    fetch();
  }

  AppState<List<Product>> carsState = AppState.initial();

  Future<void> fetch() async {
    carsState = AppState.loading();
    notifyListeners();

    try {
      final cars = await _read(productRepository).index(withAuth: true);

      carsState = AppState.data(data: cars.data);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      carsState = AppState.error(message: e.message);
      notifyListeners();
    }
  }
}
