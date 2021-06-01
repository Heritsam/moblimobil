import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../models/other/choose_us.dart';
import '../models/other/slider.dart';

final otherRepository = Provider<OtherRepository>(
    (ref) => OtherRepositoryImpl(ref.watch(dioClient)));

abstract class OtherRepository {
  Future<List<SliderBanner>> getSlider();
  Future<List<ChooseUs>> getChooseUs();
}

class OtherRepositoryImpl implements OtherRepository {
  final DioClient _client;

  const OtherRepositoryImpl(this._client);

  @override
  Future<List<SliderBanner>> getSlider() async {
    try {
      final response = await _client.get('/api/slider');

      return SliderBannerResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  @override
  Future<List<ChooseUs>> getChooseUs() async {
    try {
      final response = await _client.get('/api/choose-us');

      return ChooseUsResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
