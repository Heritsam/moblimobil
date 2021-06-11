import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/product/product.dart';
import '../../../../infrastructures/repositories/product_repository.dart';

final vendorCarsNotifier = ChangeNotifierProvider<VendorCarsNotifier>((ref) {
  return VendorCarsNotifier(ref.read);
});

class VendorCarsNotifier extends ChangeNotifier {
  final Reader _read;

  VendorCarsNotifier(this._read) {
    fetch();
  }

  AppState<List<Product>> carState = AppState.initial();
  int totalCar = 0;

  Future<void> fetch() async {
    carState = AppState.loading();
    notifyListeners();

    try {
      final cars = await _read(productRepository).index(withAuth: true);

      carState = AppState.data(data: cars.data);
      totalCar = cars.total;

      notifyListeners();
    } on NetworkExceptions catch (e) {
      e.maybeWhen(
        defaultError: (message, response) {
          if (message == 'notfound') {
            carState = AppState.data(data: []);
            totalCar = 0;
          } else {
            carState = AppState.error(message: e.message);
            totalCar = 0;
          }
        },
        orElse: () {
          carState = AppState.error(message: e.message);
        },
      );
      notifyListeners();
    }
  }
}
