import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../../core/utils/preferences_key.dart';
import '../../providers.dart';
import '../models/product/product.dart';
import '../models/product/product_index.dart';
import '../models/sort/sort_template.dart';

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
    SortTemplate? rangePrice,
    SortTemplate? rangeKm,
    String? yearBefore,
    String? yearAfter,
    SortTemplate? byYear,
    int? cityId,
    int? brandId,
    int? bodyTypeId,
    int? fuelTypeId,
    int? transmissionId,
    int? colorId,
    bool withAuth = false,
  });
  Future<Product> detail(int id);
  Future<String> submit(int id);
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
    SortTemplate? rangePrice,
    SortTemplate? rangeKm,
    String? yearBefore,
    String? yearAfter,
    SortTemplate? byYear,
    int? cityId,
    int? brandId,
    int? bodyTypeId,
    int? fuelTypeId,
    int? transmissionId,
    int? colorId,
    bool withAuth = false,
  }) async {
    late String? token;

    try {
      if (withAuth) {
        token = _preferences.getString(PreferencesKey.tokenKey);
      }

      final response = await _client.post(
        '/api/product',
        options: Options(
          headers: {
            if (withAuth) HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        ),
        queryParameters: {
          'page': page,
          if (sort != null) 'sort': sort,
          if (cityId != null) 'city': cityId,
          if (brandId != null) 'brand': brandId,
          if (bodyTypeId != null) 'bodytype': bodyTypeId,
          if (fuelTypeId != null) 'fueltype': fuelTypeId,
          if (transmissionId != null) 'transmission': transmissionId,
          if (colorId != null) 'color': colorId,
        },
        data: {
          if (search != null) 'search': search,
          if (rangePrice != null) 'range_price': rangePrice.filter,
          if (rangeKm != null) 'range_km': rangeKm.filter,
          if (yearBefore != null) 'year_before': yearBefore,
          if (yearAfter != null) 'year_after': yearAfter,
          if (byYear != null) 'by_year': byYear.filter,
        },
      );

      return ProductIndexResponse.fromJson(response.data);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<Product> detail(int id) async {
    try {
      final response = await _client.get('/api/product/$id');

      return Product.fromJson(response.data['data'][0]);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<String> submit(int id) async {
    try {
      final token = _preferences.getString(PreferencesKey.tokenKey);

      final response = await _client.get(
        '/api/product-submit/$id',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
      );

      return response.data['message'].toString();
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
