import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Image.asset(
        'assets/belimobil.png',
        height: 180,
        width: 180,
      ).center(),
    );
  }
}
