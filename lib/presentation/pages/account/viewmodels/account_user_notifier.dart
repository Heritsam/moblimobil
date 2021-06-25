import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/profile/user.dart';
import '../../../../infrastructures/repositories/profile_repository.dart';
import '../../notification/viewmodels/notification_viewmodel.dart';
import 'account_bookmark_notifier.dart';
import 'account_wishlist_notifier.dart';
import 'vendor_cars_notifier.dart';
import 'vendor_sold_notifier.dart';

final accountUserNotifier = ChangeNotifierProvider<AccountUserNotifier>((ref) {
  return AccountUserNotifier(ref.read);
});

class AccountUserNotifier extends ChangeNotifier {
  final Reader _read;

  AccountUserNotifier(this._read) {
    fetchUser();
    tabIndex = 0;
  }

  AppState<User> userState = AppState.loading();
  int tabIndex = 0;

  Future<void> fetchUser() async {
    userState = AppState.loading();
    notifyListeners();

    try {
      final user = await _read(profileRepository).me();

      userState = AppState.data(data: user);

      // Fetch user wishlist & bookmarks
      _read(accountWishlistNotifier).getWishlists();
      _read(accountBookmarkNotifier).getBookmarks();
      _read(vendorCarsNotifier).fetch();
      _read(vendorSoldNotifier).fetch();

      // refresh notification
      _read(notificationViewModel).fetch();

      notifyListeners();
    } on NetworkExceptions catch (e) {
      userState = AppState.error(message: e.message);
      notifyListeners();
    }
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }
}
