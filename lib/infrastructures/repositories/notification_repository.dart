import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../../core/utils/preferences_key.dart';
import '../../providers.dart';
import '../models/notification/notification.dart';
import '../models/notification/notification_index.dart';

final notificationRepository = Provider<NotificationRepository>((ref) {
  final dio = ref.watch(dioClient);
  final preferences = ref.watch(sharedPreferences);

  return NotificationRepositoryImpl(dio, preferences);
});

abstract class NotificationRepository {
  Future<NotificationIndexResponse> index({int page = 1});
  Future<MobliNotif> detail(int id);
  Future<void> read(int id);
}

class NotificationRepositoryImpl implements NotificationRepository {
  final DioClient _client;
  final SharedPreferences _preferences;

  const NotificationRepositoryImpl(this._client, this._preferences);

  @override
  Future<NotificationIndexResponse> index({int page = 1}) async {
    try {
      final token = _preferences.getString(PreferencesKey.tokenKey);

      final response = await _client.get(
        '/api/notification',
        queryParameters: {'page': page},
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
      );

      return NotificationIndexResponse.fromJson(response.data);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<MobliNotif> detail(int id) async {
    try {
      final token = _preferences.getString(PreferencesKey.tokenKey);

      final response = await _client.get(
        '/api/notification/$id',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
      );

      return MobliNotif.fromJson(response.data['data'][0]);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<void> read(int id) async {
    try {
      final token = _preferences.getString(PreferencesKey.tokenKey);

      await _client.post(
        '/api/notification-read',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
        data: {'notification_id': id},
      );
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
