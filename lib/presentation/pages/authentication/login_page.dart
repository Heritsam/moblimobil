import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/circle_button.dart';
import '../../widgets/buttons/rounded_button.dart';
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
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Consumer(
      builder: (context, watch, child) {
        final vm = watch(loginViewModel);

        return Scaffold(
          extendBody: true,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 24),
            child: <Widget>[
              SizedBox(height: mediaQuery.padding.top),
              Image.asset(
                'assets/illustration_user.png',
                width: 140,
                height: 140,
              ),
              SizedBox(height: 16),
              Text(
                S.of(context).welcomeText,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: darkGreyColor,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  labelText: S.of(context).emailField,
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordNode);
                },
              ).padding(horizontal: 24),
              SizedBox(height: 8),
              TextField(
                focusNode: _passwordNode,
                decoration: InputDecoration(
                  labelText: S.of(context).passwordField,
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read(loginViewModel).toggleObscure();
                    },
                    icon: Icon(
                      vm.isObscured ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                obscureText: vm.isObscured,
              ).padding(horizontal: 24),
              SizedBox(height: 16),
              Row(
                children: [
                  InkResponse(
                    onTap: () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
                    child: Text(
                      S.of(context).forgotPassword,
                      style: TextStyle(color: blueColor),
                    ),
                  )
                ],
              ).padding(horizontal: 24),
              SizedBox(height: 16),
              Row(
                children: [
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
                ],
              ).padding(horizontal: 16),
              SizedBox(height: 32),
              RoundedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                label: S.of(context).login.toUpperCase(),
                elevated: false,
              ).constrained(width: size.width).padding(horizontal: 24),
              SizedBox(height: 16),
              RoundedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                label: S.of(context).register.toUpperCase(),
                backgroundColor: Colors.black,
                elevated: false,
              ).constrained(width: size.width).padding(horizontal: 24),
              SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/google_logo.png',
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(width: 8),
                    Text(S.of(context).loginWithGoogle.toUpperCase())
                        .textColor(Colors.black),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ).constrained(width: size.width).padding(horizontal: 24),
              SizedBox(height: mediaQuery.padding.top),
            ].toColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ).center(),
        );
      },
    );
  }
}
