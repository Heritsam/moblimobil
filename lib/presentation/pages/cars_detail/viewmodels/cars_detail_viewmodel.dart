import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/product/product.dart';
import '../../../../infrastructures/repositories/product_repository.dart';
import '../../../../infrastructures/repositories/wishlist_repository.dart';

final carsDetailViewModel = ChangeNotifierProvider<CarsDetailViewModel>((ref) {
  return CarsDetailViewModel(ref.read);
});

class CarsDetailViewModel extends ChangeNotifier {
  final Reader _read;

  CarsDetailViewModel(this._read);

  AppState<Product> productState = AppState.initial();
  bool isWishlisted = false;
  int? wishlistId;

  Future<void> fetch(int id) async {
    productState = AppState.loading();
    isWishlisted = false;
    notifyListeners();

    try {
      final cars = await _read(productRepository).detail(id);

      await checkWishlisted(cars.id);

      productState = AppState.data(data: cars);

      notifyListeners();
    } on NetworkExceptions catch (e) {
      productState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> checkWishlisted(int id) async {
    try {
      final wishlisted = await _read(wishlistRepository).check(id, 'product');

      isWishlisted = wishlisted.wishlisted;
      wishlistId = wishlisted.id;
    } catch (e) {
      return checkWishlisted(id);
    }
  }

  Future<void> addToWishlist(BuildContext context, int carId) async {
    try {
      isWishlisted = true;
      notifyListeners();

      await _read(wishlistRepository).add(carId, 'product');
      await checkWishlisted(carId);
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));

      isWishlisted = false;
      notifyListeners();
    }
  }

  Future<void> removeFromWishlist(BuildContext context, int carId) async {
    try {
      isWishlisted = false;
      notifyListeners();

      await _read(wishlistRepository).remove(wishlistId!);
      await checkWishlisted(carId);
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));

      isWishlisted = true;
      notifyListeners();
    }
  }
}
