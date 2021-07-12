// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../core/exceptions/network_exceptions.dart';

// final deepLinkRepository = Provider<DeeplinkRepository>((ref) {
//   return DeeplinkRepositoryImpl();
// });

// abstract class DeeplinkRepository {
//   Future<String> createDynamicLink(int productId);
// }

// class DeeplinkRepositoryImpl implements DeeplinkRepository {
//   @override
//   Future<String> createDynamicLink(int productId) async {
//     try {
//       var parameters = DynamicLinkParameters(
//         uriPrefix: 'https://belimobil.page.link',
//         link: Uri.parse('https://belimobil.link/mobil/$productId'),
//         androidParameters: AndroidParameters(
//           packageName: "com.belimobil.app",
//         ),
//         iosParameters: IosParameters(
//           bundleId: "com.belimobil.app",
//           appStoreId: '1498909115',
//         ),
//       );
//       var shortLink = await parameters.buildShortLink();
//       var shortUrl = shortLink.shortUrl;

//       return shortUrl.toString();
//     } catch (e) {
//       throw NetworkExceptions.getDioException(e);
//     }
//   }
// }
