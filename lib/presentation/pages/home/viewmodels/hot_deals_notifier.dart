import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastructures/models/product/product_index.dart';
import '../../../../infrastructures/repositories/product_repository.dart';

final hotDealsNotifier = ChangeNotifierProvider<HotDealsNotifier>((ref) {
  return HotDealsNotifier(ref.read);
});

class HotDealsNotifier extends ChangeNotifier {
  final Reader _read;

  HotDealsNotifier(this._read) {
    fetch();
  }

  List<Product> items = [];
  bool isLoading = false;

  Future<void> fetch() async {
    isLoading = true;
    notifyListeners();

    try {
      items = await _read(productRepository).index();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      fetch();
    }
  }
}
