import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructures/models/car.dart';

final wishlistNotifier = ChangeNotifierProvider((ref) => WishlistNotifier());

class WishlistNotifier extends ChangeNotifier {
  List<Car> wishlists = [];

  bool isWishlisted(Car car) {
    return wishlists.contains(car);
  }

  void addToWishlist(Car car) {
    wishlists.add(car);
    notifyListeners();
  }

  void removeFromWishlist(Car car) {
    wishlists.remove(car);
    notifyListeners();
  }
}
