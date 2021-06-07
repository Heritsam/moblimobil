import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../../core/utils/preferences_key.dart';
import '../../providers.dart';
import '../models/wishlist/wishlist.dart';
import '../models/wishlist/wishlist_status.dart';

final wishlistRepository = Provider<WishlistRepository>((ref) {
  final dio = ref.watch(dioClient);
  final preferences = ref.watch(sharedPreferences);

  return WishlistRepositoryImpl(dio, preferences);
});

abstract class WishlistRepository {
  Future<List<Wishlist>> index(String type);
  Future<void> add(int id, String type);
  Future<WishlistStatus> check(int id, String type);
  Future<void> remove(int id);
}

class WishlistRepositoryImpl implements WishlistRepository {
  final DioClient _client;
  final SharedPreferences _preferences;

  WishlistRepositoryImpl(this._client, this._preferences);

  @override
  Future<List<Wishlist>> index(String type) async {
    try {
      final token = _preferences.getString(PreferencesKey.tokenKey);

      final response = await _client.get(
        '/api/wishlist/$type',
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        }),
      );

      return WishlistResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<void> add(int id, String type) async {
    try {
      final token = _preferences.getString(PreferencesKey.tokenKey);

      await _client.post(
        '/api/wishlist',
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        ),
        data: {
          'type': type,
          'key_id': id,
        },
      );
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<WishlistStatus> check(int id, String type) async {
    try {
      final token = _preferences.getString(PreferencesKey.tokenKey);

      final response = await _client.post(
        '/api/wishlist/check',
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        ),
        data: {
          'type': type,
          'key_id': id,
        },
      );

      return WishlistStatus(response.data['id'], response.data['wishlisted']);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<void> remove(int id) async {
    try {
      final token = _preferences.getString(PreferencesKey.tokenKey);

      await _client.delete(
        '/api/wishlist/$id',
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
