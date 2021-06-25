import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/product/product.dart';
import '../../../../infrastructures/repositories/product_repository.dart';
import '../../../widgets/dialog/progress_dialog.dart';
import '../../account/viewmodels/vendor_cars_notifier.dart';
import '../../account/viewmodels/vendor_sold_notifier.dart';

final vendorCarsDetailViewModel =
    ChangeNotifierProvider.family<VendorCarsDetailViewModel, int>((ref, carId) {
  return VendorCarsDetailViewModel(ref.read, carId);
});

class VendorCarsDetailViewModel extends ChangeNotifier {
  final Reader _read;
  final int id;

  VendorCarsDetailViewModel(this._read, this.id);

  AppState<Product> productState = AppState.initial();

  Future<void> fetch() async {
    productState = AppState.loading();
    notifyListeners();

    try {
      final cars = await _read(productRepository).detail(id);

      productState = AppState.data(data: cars);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      productState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  Future<void> delete(BuildContext context) async {
    showDialog(context: context, builder: (context) => ProgressDialog());

    try {
      await _read(productRepository).delete(id);

      Navigator.popUntil(context, ModalRoute.withName('/vendor-cars'));

      await _read(vendorCarsNotifier).fetch();
    } on NetworkExceptions catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<void> sold(BuildContext context) async {
    showDialog(context: context, builder: (context) => ProgressDialog());

    try {
      await _read(productRepository).sold(id);

      Navigator.popUntil(context, ModalRoute.withName('/home'));

      await _read(vendorCarsNotifier).fetch();
      await _read(vendorSoldNotifier).fetch();
    } on NetworkExceptions catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
