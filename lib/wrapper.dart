import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/notifiers/splash_screen/splash_screen_notifier.dart';
import 'presentation/pages/splash_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(splashScreenNotifier.notifier).initialize();
    });

    return Scaffold(
      body: ProviderListener(
        provider: splashScreenNotifier,
        onChange: (context, SplashScreenState state) {
          state.maybeWhen(
            initialized: () {
              Navigator.pushReplacementNamed(context, '/onboarding');
            },
            orElse: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Unexpected error'),
                duration: Duration(seconds: 2),
              ));
            },
          );
        },
        child: SplashScreen(),
      ),
    );
  }
}
