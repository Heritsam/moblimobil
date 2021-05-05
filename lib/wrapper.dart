import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/notifiers/authentication/authentication_notifier.dart';
import 'presentation/pages/splash_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(authenticationNotifier.notifier).initialize();
    });
    
    return Scaffold(
      body: ProviderListener(
        provider: authenticationNotifier,
        onChange: (context, AuthenticationState state) {
          state.maybeWhen(
            unauthenticated: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            authenticated: () {
              Navigator.pushReplacementNamed(context, '/home');
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
