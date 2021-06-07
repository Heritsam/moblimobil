import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moblimobil/core/exceptions/network_exceptions.dart';

import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/product/product.dart';
import '../../../../infrastructures/repositories/product_repository.dart';

final carCompareViewModel = ChangeNotifierProvider<CarCompareViewModel>((ref) {
  return CarCompareViewModel(ref.read);
});

class CarCompareViewModel extends ChangeNotifier {
  final Reader _read;

  CarCompareViewModel(this._read) {
    fetch();
  }

  AppState<List<Product>> carsState = AppState.initial();
  List<Product> selectedCars = [];

  Future<void> fetch() async {
    carsState = AppState.loading();
    notifyListeners();

    try {
      final cars = await _read(productRepository).index();
      carsState = AppState.data(data: cars.data);

      notifyListeners();
    } on NetworkExceptions catch (e) {
      carsState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  void addCar({
    required BuildContext context,
    required Product car,
  }) {
    if (selectedCars.length == 4) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Couldn\'t add more cars'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    if (selectedCars.contains(car)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You\'ve already selected this car'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    selectedCars.add(car);
    notifyListeners();
  }

  void removeCar(Product car) {
    selectedCars.remove(car);
    notifyListeners();
  }
}
