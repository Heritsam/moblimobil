import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/exceptions/network_exceptions.dart';

final onesignalRepository =
    Provider<OnesignalRepository>((ref) => OnesignalRepositoryImpl());

abstract class OnesignalRepository {
  void setExternalUserId(int id);
  void removeExternalUserId();
}

class OnesignalRepositoryImpl implements OnesignalRepository {
  @override
  void setExternalUserId(int id) {
    try {
      OneSignal.shared.setExternalUserId(id.toString());
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  void removeExternalUserId() {
    try {
      OneSignal.shared.removeExternalUserId();
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
