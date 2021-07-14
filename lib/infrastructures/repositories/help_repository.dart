import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../../core/utils/preferences_key.dart';
import '../../providers.dart';

final helpRepository = Provider<HelpRepository>((ref) {
  final dio = ref.watch(dioClient);
  final preferences = ref.watch(sharedPreferences);

  return HelpRepositoryImpl(dio, preferences);
});

abstract class HelpRepository {
  Future<void> sendHelp({required String description});
}

class HelpRepositoryImpl implements HelpRepository {
  final DioClient _client;
  final SharedPreferences _preferences;

  const HelpRepositoryImpl(this._client, this._preferences);

  @override
  Future<void> sendHelp({required String description}) async {
    try {
      final token = _preferences.getString(PreferencesKey.tokenKey);

      await _client.post(
        '/api/bantuan',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
        data: {'description': description},
      );
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
