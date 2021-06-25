import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/notification/notification.dart';
import '../../../../infrastructures/repositories/notification_repository.dart';
import 'notification_viewmodel.dart';

final notificationDetailViewModel =
    ChangeNotifierProvider.family<NotificationDetailViewModel, int>(
        (ref, notifId) {
  return NotificationDetailViewModel(ref.read, notifId);
});

class NotificationDetailViewModel extends ChangeNotifier {
  final Reader _read;
  final int id;

  NotificationDetailViewModel(this._read, this.id);

  AppState<MobliNotif> notifState = AppState.initial();

  Future<void> fetch() async {
    notifState = AppState.loading();
    notifyListeners();

    try {
      final notif = await _read(notificationRepository).detail(id);

      notifState = AppState.data(data: notif);
      notifyListeners();

      // set notification to read
      await _read(notificationRepository).read(id);
      await _read(notificationViewModel).fetch();
    } on NetworkExceptions catch (e) {
      notifState = AppState.error(message: e.message);
      notifyListeners();
    }
  }
}
