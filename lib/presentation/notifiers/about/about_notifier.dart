import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/exceptions/network_exceptions.dart';
import '../../../core/providers/app_state.dart';
import '../../../infrastructures/models/other/about.dart';
import '../../../infrastructures/repositories/other_repository.dart';

final aboutNotifier = ChangeNotifierProvider<AboutNotifier>((ref) {
  return AboutNotifier(ref.read);
});

class AboutNotifier extends ChangeNotifier {
  final Reader _read;

  AboutNotifier(this._read) {
    fetch();
  }

  AppState<About> aboutState = AppState.initial();

  Future<void> fetch() async {
    aboutState = AppState.loading();
    notifyListeners();

    try {
      final about = await _read(otherRepository).aboutUs();

      aboutState = AppState.data(data: about);
      notifyListeners();
    } on NetworkExceptions catch (e) {
      aboutState = AppState.error(message: e.message);
      notifyListeners();
    }
  }
}
