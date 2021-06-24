import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastructures/models/location/city.dart';
import '../../../../infrastructures/repositories/location_repository.dart';

final homeCityNotifier = ChangeNotifierProvider<HomeCityNotifier>((ref) {
  return HomeCityNotifier(ref.read);
});

class HomeCityNotifier extends ChangeNotifier {
  final Reader _read;

  HomeCityNotifier(this._read) {
    fetch();
  }

  List<City> items = [];
  bool isLoading = false;

  Future<void> fetch() async {
    isLoading = true;
    notifyListeners();

    try {
      items = await _read(locationRepository).cityAll();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      fetch();
    }
  }
}
