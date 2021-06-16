import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/product/product_last_view.dart';
import '../../../../infrastructures/repositories/product_repository.dart';

final searchRecentViewModel =
    ChangeNotifierProvider<SearchRecentViewModel>((ref) {
  return SearchRecentViewModel(ref.read);
});

class SearchRecentViewModel extends ChangeNotifier {
  final Reader _read;

  SearchRecentViewModel(this._read) {
    fetch();
  }

  AppState<List<ProductLastView>> productState = AppState.initial();

  Future<void> fetch() async {
    productState = AppState.loading();
    notifyListeners();

    try {
      final products = await _read(productRepository).lastViewed();

      productState = AppState.data(data: products.data);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      productState = AppState.error(message: e.message);
      notifyListeners();
    }
  }
}
