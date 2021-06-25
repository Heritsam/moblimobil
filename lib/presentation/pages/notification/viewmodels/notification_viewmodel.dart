import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/notification/notification.dart';
import '../../../../infrastructures/repositories/notification_repository.dart';

final notificationViewModel =
    ChangeNotifierProvider<NotificationViewModel>((ref) {
  return NotificationViewModel(ref.read);
});

class NotificationViewModel extends ChangeNotifier {
  final Reader _read;

  NotificationViewModel(this._read) {
    fetch();
  }

  AppState<List<MobliNotif>> notifState = AppState.initial();

  Future<void> fetch() async {
    notifState = AppState.loading();
    notifyListeners();

    try {
      final items = await _read(notificationRepository).index();

      notifState = AppState.data(data: items.data);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      notifState = AppState.error(message: e.message);
      notifyListeners();
    }
  }
}
