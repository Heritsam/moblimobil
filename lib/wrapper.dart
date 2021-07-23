import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/notifiers/splash_screen/splash_screen_notifier.dart';
import 'presentation/pages/splash_screen.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(splashScreenNotifier.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderListener(
        provider: splashScreenNotifier,
        onChange: (context, SplashScreenState state) {
          state.maybeWhen(
            initialized: () async {
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
