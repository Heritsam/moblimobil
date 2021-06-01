import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../models/location/city.dart';
import '../models/location/province.dart';
import '../models/location/subdistrict.dart';

final locationRepository = Provider<LocationRepository>((ref) {
  return LocationRepositoryImpl(ref.watch(dioClient));
});

abstract class LocationRepository {
  Future<List<Province>> getProvinces();
  Future<List<City>> getCities(int provinceId);
  Future<List<Subdistrict>> getSubdistrict(int cityId);
}

class LocationRepositoryImpl implements LocationRepository {
  final DioClient _client;

  const LocationRepositoryImpl(this._client);

  @override
  Future<List<Province>> getProvinces() async {
    try {
      final response = await _client.get('/api/provinces');

      return ProvinceResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<List<City>> getCities(int provinceId) async {
    try {
      final response = await _client.get('/api/city/$provinceId');

      return CityResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<List<Subdistrict>> getSubdistrict(int cityId) async {
    try {
      final response = await _client.get('/api/subdistrict/$cityId');

      return SubDistrictResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
