import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../../core/utils/preferences_key.dart';
import '../../providers.dart';
import '../models/iuran/iuran.dart';
import '../params/iuran/pay_iuran_params.dart';

final iuranRepository = Provider<IuranRepository>((ref) {
  final dio = ref.watch(dioClient);
  final preferences = ref.watch(sharedPreferences);

  return IuranRepositoryImpl(dio, preferences);
});

abstract class IuranRepository {
  Future<void> pay(PayIuranParams params);
  Future<IuranResponse> index({int page = 1});
}

class IuranRepositoryImpl implements IuranRepository {
  final DioClient _client;
  final SharedPreferences _preferences;

  const IuranRepositoryImpl(this._client, this._preferences);

  @override
  Future<void> pay(PayIuranParams params) async {
    try {
      final token = _preferences.getString(PreferencesKey.tokenKey);

      await _client.post(
        '/api/fee',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
        data: FormData.fromMap(params.toJson()),
      );
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<IuranResponse> index({int page = 1}) async {
    try {
      final token = _preferences.getString(PreferencesKey.tokenKey);

      final response = await _client.get(
        '/api/fee',
        queryParameters: {'page': page},
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
      );

      return IuranResponse.fromJson(response.data);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
