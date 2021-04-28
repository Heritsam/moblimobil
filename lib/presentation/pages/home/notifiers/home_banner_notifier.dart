import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeBannerNotifier = ChangeNotifierProvider<HomeBannerNotifier>((ref) {
  return HomeBannerNotifier();
});

class HomeBannerNotifier extends ChangeNotifier {
  List<String> items = [
    'assets/banner.jpg',
    'assets/banner.jpg',
    'assets/banner.jpg',
  ];
  int index = 0;

  void indexChanged(int idx) {
    index = idx;
    notifyListeners();
  }
}
