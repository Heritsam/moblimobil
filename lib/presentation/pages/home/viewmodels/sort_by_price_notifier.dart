import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/models/product/product.dart';
import '../../../../infrastructures/repositories/product_repository.dart';

final sortByPriceNotifier = ChangeNotifierProvider<SortByPrice>((ref) {
  return SortByPrice(ref.read);
});

class SortByPrice extends ChangeNotifier {
  final Reader _read;

  SortByPrice(this._read) {
    fetch();
  }

  List<PriceTemplate> prices = [
    PriceTemplate('≤ 100 jt', '<100'),
    PriceTemplate('100 jt - 300 jt', '100-300'),
    PriceTemplate('300 jt - 500 jt', '300-500'),
    PriceTemplate('≥ 500 jt', '>500'),
  ];
  String filter = '<100';

  List<Product> items = [];
  bool isLoading = false;

  void changePrice(String newFilter) {
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

class PriceTemplate {
  final String label;
  final String filter;

  const PriceTemplate(this.label, this.filter);
}
