import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/exceptions/network_exceptions.dart';
import '../../../infrastructures/models/wishlist/wishlist.dart';
import '../../../infrastructures/repositories/wishlist_repository.dart';

final wishlistNotifier = ChangeNotifierProvider<WishlistNotifier>((ref) {
  return WishlistNotifier(ref.read);
});

class WishlistNotifier extends ChangeNotifier {
  final Reader _read;

  WishlistNotifier(this._read);

  Future<List<Wishlist>> index(BuildContext context, String type) async {
    try {
      final items = await _read(wishlistRepository).index(type);

      return items;
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));

      return index(context, type);
    }
  }

  Future<void> add(
    BuildContext context, {
    required int id,
    required String type,
  }) async {
    try {
      await _read(wishlistRepository).add(id, type);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));
    } catch (_) {
      rethrow;
    }
  }

  Future<void> remove(BuildContext context, int id) async {
    try {
      await _read(wishlistRepository).remove(id);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));
    } catch (_) {
      rethrow;
    }
  }
}
