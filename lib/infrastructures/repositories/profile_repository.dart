import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/dio_client.dart';
import '../../providers.dart';

final profileRepository = Provider<ProfileRepository>((ref) {
  final dio = ref.watch(dioClient);
  final preferences = ref.watch(sharedPreferences);
  
  return ProfileRepositoryImpl(dio, preferences);
});

abstract class ProfileRepository {}

class ProfileRepositoryImpl implements ProfileRepository {
  final DioClient _client;
  final SharedPreferences _preferences;

  const ProfileRepositoryImpl(this._client, this._preferences);
}
