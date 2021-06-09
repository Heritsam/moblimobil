import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/models/product/product.dart';
import '../../../../infrastructures/models/sort/sort_template.dart';
import '../../../../infrastructures/repositories/product_repository.dart';

final sortByPriceNotifier = ChangeNotifierProvider<SortByPrice>((ref) {
  return SortByPrice(ref.read);
});

class SortByPrice extends ChangeNotifier {
  final Reader _read;

  SortByPrice(this._read) {
    fetch();
  }

  SortTemplate filter = SortTemplate.prices[0];

  List<Product> items = [];
  bool isLoading = false;

  void changePrice(SortTemplate newFilter) {
    filter = newFilter;
    notifyListeners();
    fetch();
  }

  Future<void> fetch() async {
    isLoading = true;
    notifyListeners();

    try {
      final cars = await _read(productRepository).index(rangePrice: filter);
      items = cars.data;
      isLoading = false;
      notifyListeners();
    } on NetworkExceptions catch (e) {
      e.maybeWhen(
        defaultError: (message, response) {
          if (response!.statusCode == 404) {
            items = [];
          }
        },
        orElse: () {
          fetch();
        },
      );
    }

    isLoading = false;
    notifyListeners();
  }
}
