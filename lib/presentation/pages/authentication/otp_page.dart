import 'package:flutter/material.dart';
import 'package:moblimobil/generated/l10n.dart';
import 'package:moblimobil/presentation/widgets/buttons/rounded_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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
        padding: EdgeInsets.all(24),
        child: <Widget>[
          SizedBox(height: mediaQuery.padding.top + 56),
          Image.asset(
            'assets/illustration_user.png',
            width: 140,
            height: 140,
          ),
          SizedBox(height: 16),
          Text(
            'Hi... Ade',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: darkGreyColor,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 32),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Please confirm that '),
                TextSpan(text: 'aderohayat@rohayat.com').fontWeight(FontWeight.w600),
                TextSpan(
                  text:
                      ' is you with enter the code we sent to your email.',
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ).padding(horizontal: 16),
          SizedBox(height: 32),
          PinCodeTextField(
            appContext: context,
            length: 5,
            onChanged: (value) {},
            animationType: AnimationType.none,
            mainAxisAlignment: MainAxisAlignment.center,
            pinTheme: PinTheme(
              selectedColor: blueColor,
              inactiveColor: Colors.black,
              borderWidth: 1,
              fieldOuterPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ).padding(),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).notReceiveCode).textColor(darkGreyColor),
              InkResponse(
                onTap: () {},
                child:
                    Text(S.of(context).resendCode).fontWeight(FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 64),
          RoundedButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/login'));
              Navigator.pushReplacementNamed(context, '/home');
            },
            label: S.of(context).confirm.toUpperCase(),
            elevated: false,
          ).constrained(width: size.width),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.center).center(),
      ),
    );
  }
}
