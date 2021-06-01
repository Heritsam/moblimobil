import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/themes/theme.dart';
import '../../generated/l10n.dart';
import '../widgets/buttons/rounded_button.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/illustration_user.png',
            width: 140,
            height: 140,
          ),
          SizedBox(height: 16),
          Text(
            'Hi...',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: darkGreyColor,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 58),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Selamat datang di '),
                TextSpan(text: 'LAKUMOBIL').fontWeight(FontWeight.w600),
                TextSpan(
                  text:
                      ', tempat jual beli mobil terpercaya, yang aman, cepat, dan bergaransi Yuk lanjut ke beranda.',
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ).padding(horizontal: 24),
          SizedBox(height: 64),
          RoundedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            label: '${S.of(context).login} / ${S.of(context).register}'
                .toUpperCase(),
            elevated: false,
          ).constrained(width: size.width),
          SizedBox(height: 16),
          RoundedButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/home'));
            },
            label: S.of(context).later.toUpperCase(),
            elevated: false,
            backgroundColor: Colors.black,
          ).constrained(width: size.width),
        ],
      ).padding(all: 24).center(),
    );
  }
}
