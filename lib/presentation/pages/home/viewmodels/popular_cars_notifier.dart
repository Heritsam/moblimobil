import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastructures/models/product/product_index.dart';
import '../../../../infrastructures/repositories/product_repository.dart';

final popularCarsNotifier = ChangeNotifierProvider<PopularCarsNotifier>((ref) {
  return PopularCarsNotifier(ref.read);
});

class PopularCarsNotifier extends ChangeNotifier {
  final Reader _read;

  PopularCarsNotifier(this._read) {
    fetch();
  }

  List<Product> items = [];
  bool isLoading = false;

  Future<void> fetch() async {
    isLoading = true;
    notifyListeners();

    try {
      items = await _read(productRepository).index(sort: 'popular');
      isLoading = false;
      notifyListeners();
    } catch (e) {
      fetch();
    }
  }
}
