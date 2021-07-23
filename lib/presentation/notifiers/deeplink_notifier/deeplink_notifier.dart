import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supercharged/supercharged.dart';

import '../../pages/authentication/forgot_password2_page.dart';
import '../../pages/cars_detail/cars_detail_page.dart';

final deeplinkNotifier = ChangeNotifierProvider<DeeplinkNotifier>((ref) {
  return DeeplinkNotifier();
});

class DeeplinkNotifier extends ChangeNotifier {
  void handleDeeplinks(BuildContext context, String link) async {
    final routes = link.allAfter('.link');

    if (routes.contains('car')) {
      await Future.delayed(Duration(seconds: 1));
      Navigator.pushNamed(
        context,
        '/cars-detail',
        arguments: CarsDetailArgs(int.parse(link.split('%2F').last)),
      );
      return;
    }

    if (routes.contains('forgot')) {
      Navigator.pushNamed(
        context,
        '/login',
      );
      await Future.delayed(Duration(seconds: 1));
      Navigator.pushNamed(
        context,
        '/forgot-password2',
        arguments: ForgotPassword2Args(int.parse(link.split('%2F').last)),
      );
      return;
    }
  }
}