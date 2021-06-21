import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../../core/utils/preferences_key.dart';
import '../../providers.dart';

final vendorRepository = Provider<VendorRepository>((ref) {
  final dio = ref.watch(dioClient);
  final preferences = ref.watch(sharedPreferences);

  return VendorRepositoryImpl(dio, preferences);
});

abstract class VendorRepository {
  Future<void> submit();
}

class VendorRepositoryImpl implements VendorRepository {
  final DioClient _client;
  final SharedPreferences _preferences;

  VendorRepositoryImpl(this._client, this._preferences);

  @override
  Future<void> submit() async {
    try {
      final token = _preferences.getString(PreferencesKey.tokenKey);

      await _client.post(
        '/api/submit-vendor',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
      );
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
