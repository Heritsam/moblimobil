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
  Future<List<Product>> index();
}

class ProductRepositoryImpl implements ProductRepository {
  final DioClient _client;
  final SharedPreferences _preferences;

  const ProductRepositoryImpl(this._client, this._preferences);

  @override
  Future<List<Product>> index() async {
    try {
      final response = await _client.post('/api/product');

      return ProductIndexResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
