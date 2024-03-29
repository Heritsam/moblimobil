import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../models/news/news.dart';
import '../models/news/news_index.dart';

final newsRepository = Provider<NewsRepository>((ref) {
  final dio = ref.watch(dioClient);

  return NewsRepositoryImpl(dio);
});

abstract class NewsRepository {
  Future<NewsIndexResponse> index({
    int page = 1,
    bool trending = false,
    String? search,
    int? categoryId,
  });
  Future<News> detail(int id);
}

class NewsRepositoryImpl implements NewsRepository {
  final DioClient _client;

  NewsRepositoryImpl(this._client);

  @override
  Future<NewsIndexResponse> index({
    int page = 1,
    bool trending = false,
    String? search,
    int? categoryId,
  }) async {
    try {
      final response = await _client.post(
        '/api/news',
        queryParameters: {
          'page': page,
          if (trending) 'tranding': trending,
          if (categoryId != null) 'category': categoryId,
        },
        data: {
          if (search != null) 'search': search,
        },
      );

      return NewsIndexResponse.fromJson(response.data);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<News> detail(int id) async {
    try {
      final response = await _client.get('/api/news/$id');

      return News.fromJson(response.data['data'][0]);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
