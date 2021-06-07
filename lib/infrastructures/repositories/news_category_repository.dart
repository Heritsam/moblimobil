import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../models/news/news_category.dart';

final newsCategoryRepository = Provider<NewsCategoryRepository>((ref) {
  return NewsCategoryRepositoryImpl(ref.watch(dioClient));
});

abstract class NewsCategoryRepository {
  Future<List<NewsCategory>> index();
}

class NewsCategoryRepositoryImpl implements NewsCategoryRepository {
  final DioClient _client;

  const NewsCategoryRepositoryImpl(this._client);

  @override
  Future<List<NewsCategory>> index() async {
    try {
      final response = await _client.get('/api/news-category');

      return NewsCategoryResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
