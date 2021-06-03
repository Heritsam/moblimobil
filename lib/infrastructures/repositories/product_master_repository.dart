import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../models/product_master/body_type.dart';
import '../models/product_master/brand.dart';
import '../models/product_master/car_color.dart';
import '../models/product_master/fuel_type.dart';
import '../models/product_master/transmission.dart';
import '../models/product_master/variant.dart';

final productMasterRepository = Provider<ProductMasterRepository>((ref) {
  final dio = ref.watch(dioClient);

  return ProductMasterRepositoryImpl(dio);
});

abstract class ProductMasterRepository {
  Future<BrandResponse> brands({
    int page = 1,
  });
  Future<List<BodyType>> bodyTypes();
  Future<List<FuelType>> fuelTypes();
  Future<List<CarColor>> colors();
  Future<List<Transmission>> transmissions();
  Future<List<Variant>> variants();
}

class ProductMasterRepositoryImpl implements ProductMasterRepository {
  final DioClient _client;

  ProductMasterRepositoryImpl(this._client);

  @override
  Future<BrandResponse> brands({
    int page = 1,
  }) async {
    try {
      final response = await _client.get(
        '/api/brands',
        queryParameters: {
          'page': page,
        },
      );

      return BrandResponse.fromJson(response.data);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<List<BodyType>> bodyTypes() async {
    try {
      final response = await _client.get('/api/bodytype');

      return BodyTypeResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<List<FuelType>> fuelTypes() async {
    try {
      final response = await _client.get('/api/fueltype');

      return FuelTypeResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<List<CarColor>> colors() async {
    try {
      final response = await _client.get('/api/color');

      return CarColorResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<List<Transmission>> transmissions() async {
    try {
      final response = await _client.get('/api/transmission');

      return TransmissionResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<List<Variant>> variants() async {
    try {
      final response = await _client.get('/api/variant');

      return VariantResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
