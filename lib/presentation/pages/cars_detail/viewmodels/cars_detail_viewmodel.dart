import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/product/product.dart';
import '../../../../infrastructures/repositories/product_repository.dart';
import '../../../../infrastructures/repositories/wishlist_repository.dart';
import '../../../widgets/dialog/progress_dialog.dart';
import '../../account/viewmodels/account_wishlist_notifier.dart';

final carsDetailViewModel =
    ChangeNotifierProvider.family<CarsDetailViewModel, int>((ref, carId) {
  return CarsDetailViewModel(ref.read, carId);
});

class CarsDetailViewModel extends ChangeNotifier {
  final Reader _read;
  final int id;

  CarsDetailViewModel(this._read, this.id);

  AppState<Product> productState = AppState.initial();
  bool isWishlisted = false;
  int? wishlistId;

  Future<void> fetch() async {
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
    } on NetworkExceptions catch (e) {
      e.maybeWhen(
        defaultError: (message, response) {
          if (response?.statusCode == 401) return;
        },
        orElse: () {
          checkWishlisted(id);
        },
      );
    }
  }

  Future<void> addToWishlist(BuildContext context, int carId) async {
    try {
      isWishlisted = true;
      notifyListeners();

      await _read(wishlistRepository).add(carId, 'product');
      // check wishlist status
      await checkWishlisted(carId);
      // refresh wishlist on profile page
      await _read(accountWishlistNotifier).getWishlists();
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
      // check wishlist status
      await checkWishlisted(carId);
      // refresh wishlist on profile page
      await _read(accountWishlistNotifier).getWishlists();
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));

      isWishlisted = true;
      notifyListeners();
    }
  }

  Future<void> contactWhatsapp(
    BuildContext context, {
    required int id,
    required String phone,
  }) async {
    showDialog(
      context: context,
      builder: (context) => ProgressDialog(),
      barrierDismissible: false,
    );

    try {
      final phoneNumber = phone.replaceFirst('0', '62');
      final message = await _read(productRepository).submit(id);
      final link = WhatsAppUnilink(phoneNumber: phoneNumber, text: message);

      Navigator.pop(context);

      await launch(link.toString());
    } on NetworkExceptions catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<void> callSeller(
    BuildContext context, {
    required String phone,
  }) async {
    await FlutterPhoneDirectCaller.callNumber(phone);
  }
}
