import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../models/slider/slider.dart';

final sliderRepository = Provider<SliderRepository>(
    (ref) => SliderRepositoryImpl(ref.watch(dioClient)));

abstract class SliderRepository {
  Future<List<SliderBanner>> getSlider();
}

class SliderRepositoryImpl implements SliderRepository {
  final DioClient _client;

  const SliderRepositoryImpl(this._client);

  @override
  Future<List<SliderBanner>> getSlider() async {
    try {
      final response = await _client.get('/api/slider');

      return SliderBannerResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
