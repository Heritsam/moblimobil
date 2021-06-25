import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../models/other/about.dart';
import '../models/other/choose_us.dart';
import '../models/other/slider.dart';

final otherRepository = Provider<OtherRepository>(
    (ref) => OtherRepositoryImpl(ref.watch(dioClient)));

abstract class OtherRepository {
  Future<List<SliderBanner>> sliders();
  Future<List<ChooseUs>> chooseUs();
  Future<About> aboutUs();
}

class OtherRepositoryImpl implements OtherRepository {
  final DioClient _client;

  const OtherRepositoryImpl(this._client);

  @override
  Future<List<SliderBanner>> sliders() async {
    try {
      final response = await _client.get('/api/slider');

      return SliderBannerResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<List<ChooseUs>> chooseUs() async {
    try {
      final response = await _client.get('/api/choose-us');

      return ChooseUsResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<About> aboutUs() async {
    try {
      final response = await _client.get('/api/about');

      return About.fromJson(response.data['data'][0]);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
