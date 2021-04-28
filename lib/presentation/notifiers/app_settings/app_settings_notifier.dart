import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers.dart';

final appSettingsNotifier = ChangeNotifierProvider<AppSettingsNotifier>((ref) {
  return AppSettingsNotifier(ref.watch(sharedPreferences));
});

class AppSettingsNotifier extends ChangeNotifier {
  final SharedPreferences _preferences;

  AppSettingsNotifier(this._preferences);

  String language = 'en';

  void changeLanguage(String newLanguage) {
    language = newLanguage;
    notifyListeners();
  }
}
