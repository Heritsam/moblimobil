import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:styled_widget/styled_widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SvgPicture.asset(
        'assets/logo_text.svg',
        height: 180,
        width: 180,
      ).center(),
    );
  }
}
