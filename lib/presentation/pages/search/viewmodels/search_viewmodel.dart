import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/product/product.dart';
import '../../../../infrastructures/repositories/product_repository.dart';

final searchViewModel = ChangeNotifierProvider<SearchViewModel>((ref) {
  return SearchViewModel(ref.read);
});

class SearchViewModel extends ChangeNotifier {
  final Reader _read;

  SearchViewModel(this._read) {
    search();
  }

  AppState<List<Product>> carState = AppState.initial();

  String query = '';

  Future<void> search() async {
    carState = AppState.loading();
    notifyListeners();

    try {
      final cars = await _read(productRepository).index(search: query);

      carState = AppState.data(data: cars.data);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      carState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> resetAndSearch() async {
    query = '';
    notifyListeners();
    await search();
  }

  void changeSearchText(String value) {
    query = value;
    notifyListeners();
  }
}
