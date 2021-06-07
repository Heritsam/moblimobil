import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/models/wishlist/wishlist.dart';
import '../../../../infrastructures/repositories/wishlist_repository.dart';

final accountWishlistNotifier =
    ChangeNotifierProvider<AccountWishlistNotifier>((ref) {
  return AccountWishlistNotifier(ref.read);
});

class AccountWishlistNotifier extends ChangeNotifier {
  final Reader _read;

  AccountWishlistNotifier(this._read) {
    getWishlists();
  }

  List<Wishlist> items = [];
  bool isLoading = false;

  Future<void> getWishlists() async {
    isLoading = true;
    notifyListeners();

    try {
      final wishlists = await _read(wishlistRepository).index('product');

      items = wishlists;
      isLoading = false;
      notifyListeners();
    } catch (_) {
      getWishlists();
    }
  }

  Future<void> removeWishlist(BuildContext context, int id) async {
    try {
      await _read(wishlistRepository).remove(id);
      await getWishlists();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
