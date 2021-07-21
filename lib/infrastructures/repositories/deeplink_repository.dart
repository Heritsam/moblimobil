import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/network_exceptions.dart';

final deeplinkRepository = Provider<DeeplinkRepository>((ref) {
  return DeeplinkRepositoryImpl();
});

abstract class DeeplinkRepository {
  Future<String> createDeeplink(String path);
}

class DeeplinkRepositoryImpl implements DeeplinkRepository {
  @override
  Future<String> createDeeplink(String path) async {
    try {
      final parameters = DynamicLinkParameters(
        uriPrefix: 'https://belimobil.page.link',
        link: Uri.parse('https://www.demoteknologi.com/lakumobil/$path'),
        androidParameters: AndroidParameters(
          packageName: 'com.belimobil.app',
        ),
      );

      final dynamicUrl = await parameters.buildUrl();

      return dynamicUrl.toString();
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
