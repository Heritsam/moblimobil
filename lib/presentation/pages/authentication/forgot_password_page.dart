import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        leading: BackButton(color: darkGreyColor),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(24),
        child: <Widget>[
          SizedBox(height: 56 + mediaQuery.padding.top),
          Image.asset(
            'assets/illustration_user.png',
            width: 140,
            height: 140,
          ),
          SizedBox(height: 16),
          Text(
            S.of(context).forgotPassword,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: darkGreyColor,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 32),
          Text(
            S.of(context).forgotPasswordMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 32),
          TextField(
            decoration: InputDecoration(
              labelText: S.of(context).emailField,
            ),
          ),
          SizedBox(height: 64),
          RoundedButton(
            onPressed: () {},
            label: S.of(context).send.toUpperCase(),
            elevated: false,
          ).constrained(width: size.width),
          SizedBox(height: 72 + mediaQuery.padding.top),
        ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
      ).center(),
    );
  }
}
