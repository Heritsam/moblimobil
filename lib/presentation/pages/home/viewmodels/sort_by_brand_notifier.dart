import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastructures/models/product_master/brand.dart';
import '../../../../infrastructures/repositories/product_master_repository.dart';

final sortByBrandNotifier = ChangeNotifierProvider<SortByBrandNotifier>((ref) {
  return SortByBrandNotifier(ref.read);
});

class SortByBrandNotifier extends ChangeNotifier {
  final Reader _read;

  SortByBrandNotifier(this._read) {
    fetch();
  }

  List<Brand> items = [];
  bool isLoading = false;

  Future<void> fetch() async {
    isLoading = true;
    notifyListeners();

    try {
      final brands = await _read(productMasterRepository).brands();
      items = brands.data;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      fetch();
    }
  }
}
