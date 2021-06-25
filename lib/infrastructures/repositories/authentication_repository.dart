import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../../core/utils/preferences_key.dart';
import '../../providers.dart';
import '../models/auth/email_not_verified.dart';
import '../models/auth/login_response.dart';

final authenticationRepository = Provider<AuthenticationRepository>((ref) {
  final dio = ref.watch(dioClient);
  final preferences = ref.watch(sharedPreferences);

  return AuthenticationRepositoryImpl(dio, preferences);
});

abstract class AuthenticationRepository {
  Future<LoginResponse> checkToken({
    required String token,
    required int userId,
    required String password,
  });
  Future<LoginResponse> login({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<EmailNotVerified> register({
    required String fullname,
    required String phone,
    required String email,
    required String password,
  });
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final DioClient _client;
  final SharedPreferences _preferences;

  const AuthenticationRepositoryImpl(this._client, this._preferences);

  @override
  Future<LoginResponse> checkToken({
    required String token,
    required int userId,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        '/api/check-token',
        data: {
          'user_id': userId,
          'token': token,
          'password': password,
        },
      );
      final loginData = LoginResponse.fromJson(response.data);

      _preferences.setString(PreferencesKey.tokenKey, loginData.token);
      _preferences.setInt(PreferencesKey.userKey, loginData.data.id);

      return LoginResponse.fromJson(response.data);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        '/api/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      final loginData = LoginResponse.fromJson(response.data);

      _preferences.setString(PreferencesKey.tokenKey, loginData.token);
      _preferences.setInt(PreferencesKey.userKey, loginData.data.id);

      return loginData;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _client.get('/api/logout');
      _preferences.remove(PreferencesKey.tokenKey);
      _preferences.remove(PreferencesKey.userKey);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<EmailNotVerified> register({
    required String fullname,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        '/api/register',
        data: {
          'fullname': fullname,
          'phone': phone,
          'email': email,
          'password': password,
        },
      );

      return EmailNotVerified.fromJson(response.data);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
