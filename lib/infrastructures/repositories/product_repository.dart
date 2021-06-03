import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../../providers.dart';
import '../models/product/product_index.dart';

final productRepository = Provider<ProductRepository>((ref) {
  final dio = ref.watch(dioClient);
  final preferences = ref.watch(sharedPreferences);

  return ProductRepositoryImpl(dio, preferences);
});

abstract class ProductRepository {
  Future<ProductIndexResponse> index({
    int page = 1,
    String? sort,
    String? search,
    String? rangePrice,
  });
}

class ProductRepositoryImpl implements ProductRepository {
  final DioClient _client;
  final SharedPreferences _preferences;

  const ProductRepositoryImpl(this._client, this._preferences);

  @override
  Future<ProductIndexResponse> index({
    int page = 1,
    String? sort,
    String? search,
    String? rangePrice,
  }) async {
    try {
      final response = await _client.post(
        '/api/product',
        queryParameters: {
          'page': page,
          if (sort != null) 'sort': sort,
        },
        data: {
          if (search != null) 'search': search,
          if (rangePrice != null) 'range_price': rangePrice,
        },
      );

      return ProductIndexResponse.fromJson(response.data);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
