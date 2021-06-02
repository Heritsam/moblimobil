import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../../core/utils/preferences_key.dart';
import '../../providers.dart';
import '../models/profile/user.dart';
import '../params/profile/update_profile_params.dart';

final profileRepository = Provider<ProfileRepository>((ref) {
  final dio = ref.watch(dioClient);
  final preferences = ref.watch(sharedPreferences);

  return ProfileRepositoryImpl(dio, preferences);
});

abstract class ProfileRepository {
  Future<User> me();
  Future<void> update(UpdateProfileParams params);
  Future<void> checkPassword(String oldPassword);
  Future<void> updatePassword(String newPassword);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final DioClient _client;
  final SharedPreferences _preferences;

  const ProfileRepositoryImpl(this._client, this._preferences);

  @override
  Future<User> me() async {
    final token = _preferences.getString(PreferencesKey.tokenKey);

    try {
      final response = await _client.get(
        '/api/me',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
      );

      return User.fromJson(response.data['data']);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<void> update(UpdateProfileParams params) async {
    final token = _preferences.getString(PreferencesKey.tokenKey);

    try {
      await _client.post(
        '/api/profile-update',
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
  Future<void> checkPassword(String oldPassword) async {
    final token = _preferences.getString(PreferencesKey.tokenKey);

    try {
      await _client.post(
        '/api/check-password',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
        data: {'old_password': oldPassword},
      );
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    final token = _preferences.getString(PreferencesKey.tokenKey);
    final userId = _preferences.getInt(PreferencesKey.userKey);

    try {
      await _client.post(
        '/api/update-password',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
        data: {'new_password': newPassword, 'user_id': userId},
      );
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}