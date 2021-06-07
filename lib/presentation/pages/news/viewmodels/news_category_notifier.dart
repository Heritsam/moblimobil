import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastructures/models/news/news_category.dart';
import '../../../../infrastructures/repositories/news_category_repository.dart';
import 'news_list_notifier.dart';

final newsCategoryNotifier =
    ChangeNotifierProvider<NewsCategoryNotifier>((ref) {
  return NewsCategoryNotifier(ref.read);
});

class NewsCategoryNotifier extends ChangeNotifier {
  final Reader _read;

  NewsCategoryNotifier(this._read) {
    fetch();
  }

  List<NewsCategory> items = [];
  bool isLoading = false;

  Future<void> fetch() async {
    isLoading = true;
    notifyListeners();

    try {
      final categories = await _read(newsCategoryRepository).index();
      items = categories;

      if (items.isNotEmpty) {
        _read(newsListNotifier).changeCategory(items.first.id);
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      fetch();
    }
  }
}
