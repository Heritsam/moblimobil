import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';
import '../models/faq/faq.dart';

final faqRepository =
    Provider<FaqRepository>((ref) => FaqRepositoryImpl(ref.watch(dioClient)));

abstract class FaqRepository {
  Future<List<FAQ>> faqs();
}

class FaqRepositoryImpl implements FaqRepository {
  final DioClient _client;

  const FaqRepositoryImpl(this._client);

  @override
  Future<List<FAQ>> faqs() async {
    try {
      final response = await _client.get('/api/faq');

      return FaqResponse.fromJson(response.data).data;
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
