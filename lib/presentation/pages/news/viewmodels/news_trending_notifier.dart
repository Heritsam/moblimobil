import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastructures/models/news/news.dart';
import '../../../../infrastructures/repositories/news_repository.dart';

final newsTrendingNotifier =
    ChangeNotifierProvider<NewsTrendingNotifier>((ref) {
  return NewsTrendingNotifier(ref.read);
});

class NewsTrendingNotifier extends ChangeNotifier {
  final Reader _read;

  NewsTrendingNotifier(this._read) {
    fetch();
  }

  List<News> items = [];
  bool isLoading = false;

  Future<void> fetch() async {
    isLoading = true;
    notifyListeners();

    try {
      final news = await _read(newsRepository).index(trending: true);
      items = news.data;

      isLoading = false;
      notifyListeners();
    } catch (e) {
      fetch();
    }
  }
}
