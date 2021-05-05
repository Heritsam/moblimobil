import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/circle_button.dart';
import '../../widgets/rounded_button.dart';
import 'viewmodels/login_viewmodels.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordNode = FocusNode();

  @override
  void dispose() {
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Consumer(
      builder: (context, watch, child) {
        final vm = watch(loginViewModel);

        return Scaffold(
          backgroundColor: Colors.white,
          extendBody: true,
          body: <Widget>[
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
              padding: EdgeInsets.symmetric(vertical: 24),
              child: <Widget>[
                SizedBox(height: mediaQuery.padding.top),
                SvgPicture.asset(
                  'assets/logo.svg',
                  width: 140,
                  height: 140,
                ),
                SizedBox(height: 32),
                Text(
                  S.of(context).login,
                  style: textTheme.headline6,
                ),
                SizedBox(height: 32),
                TextField(
                  decoration: InputDecoration(
                    hintText: S.of(context).phoneField,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 18),
                    hintStyle: TextStyle(color: mediumGreyColor),
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) {
                    _passwordNode.requestFocus();
                  },
                )
                    .decorated(
                      color: blueColor.withOpacity(.12),
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      border: Border.all(color: Colors.white),
                    )
                    .backgroundBlur(20)
                    .clipRRect(all: defaultBorderRadius)
                    .padding(horizontal: 24),
                SizedBox(height: 16),
                <Widget>[
                  TextField(
                    focusNode: _passwordNode,
                    decoration: InputDecoration(
                      hintText: S.of(context).passwordField,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 18),
                      hintStyle: TextStyle(color: mediumGreyColor),
                    ),
                    obscureText: vm.isObscured,
                  ).expanded(flex: 2),
                  IconButton(
                    onPressed: context.read(loginViewModel).toggleObscure,
                    icon: Icon(
                      vm.isObscured ? Icons.visibility : Icons.visibility_off,
                    ),
                    color: darkGreyColor,
                  ),
                ]
                    .toRow()
                    .decorated(
                      color: blueColor.withOpacity(.12),
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      border: Border.all(color: Colors.white),
                    )
                    .backgroundBlur(20)
                    .clipRRect(all: defaultBorderRadius)
                    .padding(horizontal: 24),
                SizedBox(height: 8),
                <Widget>[
                  <Widget>[
                    Checkbox(
                      onChanged: (_) {
                        context.read(loginViewModel).toggleRememberMe();
                      },
                      value: vm.rememberMe,
                      visualDensity: VisualDensity.compact,
                      activeColor: greenColor,
                    ),
                    SizedBox(width: 4),
                    InkResponse(
                      onTap: context.read(loginViewModel).toggleRememberMe,
                      child: Text(
                        S.of(context).rememberMe,
                        style: TextStyle(fontSize: 14, color: mediumGreyColor),
                      ),
                    ),
                  ].toRow(),
                  InkResponse(
                    onTap: () {
                      context
                          .read(loginViewModel)
                          .navigateToForgotPassword(context);
                    },
                    child: Text(
                      S.of(context).forgotPassword,
                      style: TextStyle(
                        color: blueColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ]
                    .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                    .padding(right: 24, left: 16),
                SizedBox(height: 32),
                RoundedButton(
                  onPressed: () {
                    context.read(loginViewModel).login(context);
                  },
                  label: S.of(context).login,
                ).constrained(width: 193),
                SizedBox(height: 16),
                RoundedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  label: S.of(context).register,
                  backgroundColor: darkGreyColor,
                ).constrained(width: 193),
                SizedBox(height: 16),
                Text(S.of(context).or,
                    style: TextStyle(color: mediumGreyColor)),
                SizedBox(height: 16),
                CircleButton(
                  child: Image.asset(
                    'assets/google_logo.png',
                    height: 32,
                    width: 32,
                  ),
                ),
                SizedBox(height: 8),
                Text(S.of(context).loginWithGoogle,
                    style: TextStyle(color: mediumGreyColor)),
              ].toColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ).center(),
          ].toStack(
            fit: StackFit.passthrough,
            alignment: Alignment.bottomCenter,
          ),
        );
      },
    );
  }
}
