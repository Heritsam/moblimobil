import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/network_exceptions.dart';
import '../../core/utils/dio_client.dart';

final helpRepository =
    Provider<HelpRepository>((ref) => HelpRepositoryImpl(ref.watch(dioClient)));

abstract class HelpRepository {
  Future<void> sendHelp({
    required String fullname,
    required String description,
  });
}

class HelpRepositoryImpl implements HelpRepository {
  final DioClient _client;

  const HelpRepositoryImpl(this._client);

  @override
  Future<void> sendHelp({
    required String fullname,
    required String description,
  }) async {
    try {
      await _client.post(
        '/api/bantuan',
        data: {
          'fullname': fullname,
          'description': description,
        },
      );
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
