import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastructures/models/news/news.dart';
import '../../../../infrastructures/repositories/news_repository.dart';

final newsListNotifier = ChangeNotifierProvider<NewsListNotifier>((ref) {
  return NewsListNotifier(ref.read);
});

class NewsListNotifier extends ChangeNotifier {
  final Reader _read;

  NewsListNotifier(this._read) {
    fetch();
  }

  List<News> items = [];
  bool isLoading = false;
  String query = '';
  int? selectedCategoryId;

  Future<void> fetch() async {
    isLoading = true;
    notifyListeners();

    try {
      final news = await _read(newsRepository).index(
        search: query,
        categoryId: selectedCategoryId,
      );

      items = news.data;

      isLoading = false;
      notifyListeners();
    } catch (e) {
      fetch();
    }
  }

  void changeCategory(int id) {
    selectedCategoryId = id;
    notifyListeners();
  }

  Future<void> resetAndSearch() async {
    query = '';
    notifyListeners();
    await fetch();
  }

  void changeSearchText(String value) {
    query = value;
    notifyListeners();
  }
}
