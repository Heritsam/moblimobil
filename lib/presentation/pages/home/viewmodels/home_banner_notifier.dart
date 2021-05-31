import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastructures/models/slider/slider.dart';
import '../../../../infrastructures/repositories/slider_repository.dart';

final homeBannerNotifier = ChangeNotifierProvider<HomeBannerNotifier>((ref) {
  return HomeBannerNotifier(ref.read);
});

class HomeBannerNotifier extends ChangeNotifier {
  final Reader _read;

  HomeBannerNotifier(this._read) {
    fetchSlider();
  }

  List<SliderBanner> items = [];

  int index = 0;
  bool isLoading = false;

  void indexChanged(int idx) {
    index = idx;
    notifyListeners();
  }

  Future<void> fetchSlider() async {
    isLoading = true;
    notifyListeners();

    try {
      items = await _read(sliderRepository).getSlider();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      fetchSlider();
    }
  }
}
