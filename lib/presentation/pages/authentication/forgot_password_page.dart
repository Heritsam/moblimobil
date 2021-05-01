import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/rounded_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _phoneNode = FocusNode();

  @override
  void dispose() {
    _phoneNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        leading: BackButton(color: darkGreyColor),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            height: size.height / 2.5,
            width: size.width * 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg_wave.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            child: <Widget>[
              SizedBox(height: 56 + mediaQuery.padding.top),
              SvgPicture.asset(
                'assets/logo.svg',
                width: 140,
                height: 140,
              ),
              SizedBox(height: 32),
              Text(
                S.of(context).forgotPassword,
                style: textTheme.headline6,
              ),
              SizedBox(height: 32),
              Text(
                S.of(context).forgotPasswordMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: darkGreyColor),
              ),
              SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(
                  hintText: S.of(context).fullNameField,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 18),
                  hintStyle: TextStyle(color: mediumGreyColor),
                ),
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_phoneNode);
                },
              )
                  .decorated(
                    color: blueColor.withOpacity(.12),
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    border: Border.all(color: Colors.white),
                  )
                  .backgroundBlur(20)
                  .clipRRect(all: defaultBorderRadius),
              SizedBox(height: 16),
              TextField(
                focusNode: _phoneNode,
                decoration: InputDecoration(
                  hintText: S.of(context).phoneField,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 18),
                  hintStyle: TextStyle(color: mediumGreyColor),
                ),
                keyboardType: TextInputType.phone,
              )
                  .decorated(
                    color: blueColor.withOpacity(.12),
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    border: Border.all(color: Colors.white),
                  )
                  .backgroundBlur(20)
                  .clipRRect(all: defaultBorderRadius),
              SizedBox(height: 64),
              RoundedButton(
                onPressed: () {},
                label: S.of(context).send,
              ),
              SizedBox(height: 72 + mediaQuery.padding.top),
            ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
          ).center(),
        ].toStack(alignment: Alignment.bottomCenter),
      ),
    );
  }
}
