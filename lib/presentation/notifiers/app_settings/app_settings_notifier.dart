import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appSettingsNotifier = ChangeNotifierProvider<AppSettingsNotifier>((ref) {
  return AppSettingsNotifier();
});

class AppSettingsNotifier extends ChangeNotifier {
  String language = 'en';

  void changeLanguage(String newLanguage) {
    language = newLanguage;
    notifyListeners();
  }
}
