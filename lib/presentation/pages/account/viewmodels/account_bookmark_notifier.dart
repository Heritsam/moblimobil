import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/models/wishlist/wishlist.dart';
import '../../../../infrastructures/repositories/wishlist_repository.dart';

final accountBookmarkNotifier =
    ChangeNotifierProvider<AccountBookmarkNotifier>((ref) {
  return AccountBookmarkNotifier(ref.read);
});

class AccountBookmarkNotifier extends ChangeNotifier {
  final Reader _read;

  AccountBookmarkNotifier(this._read) {
    getBookmarks();
  }

  List<Wishlist> items = [];
  bool isLoading = false;

  Future<void> getBookmarks() async {
    isLoading = true;
    notifyListeners();

    try {
      final wishlists = await _read(wishlistRepository).index('news');

      items = wishlists;
      isLoading = false;
      notifyListeners();
    } on NetworkExceptions catch (e) {
      e.maybeWhen(
        defaultError: (message, response) {
          if (message == 'not_found') {
            isLoading = false;
            notifyListeners();
          }
        },
        orElse: () {
          getBookmarks();
        },
      );
    }
  }

  Future<void> removeBookmark(BuildContext context, int id) async {
    try {
      await _read(wishlistRepository).remove(id);
      await getBookmarks();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
