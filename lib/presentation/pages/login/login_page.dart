import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/rounded_button.dart';
import 'notifiers/login_notifier.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer(
      builder: (context, watch, child) {
        final vm = watch(loginNotifier);

        return Scaffold(
          extendBody: true,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: <Widget>[
              FlutterLogo(size: 125),
              SizedBox(height: 24),
              Text(
                S.of(context).welcomeText,
                style:
                    textTheme.headline5?.copyWith(fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(
                  labelText: S.of(context).phoneField,
                ),
              ).padding(horizontal: 16),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: S.of(context).passwordField,
                  suffixIcon: IconButton(
                    onPressed: context.read(loginNotifier).toggleObscure,
                    icon: Icon(vm.isObscured
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
                obscureText: vm.isObscured,
              ).padding(horizontal: 16),
              SizedBox(height: 32),
              <Widget>[
                InkResponse(
                  onTap: () {
                    context
                        .read(loginNotifier)
                        .navigateToForgotPassword(context);
                  },
                  child: Text(
                    S.of(context).forgotPassword,
                    style: TextStyle(color: blueColor),
                  ),
                )
              ].toRow().padding(horizontal: 16),
              SizedBox(height: 16),
              <Widget>[
                Checkbox(
                  onChanged: (_) {
                    context.read(loginNotifier).toggleRememberMe();
                  },
                  value: vm.rememberMe,
                  visualDensity: VisualDensity.compact,
                  activeColor: greenColor,
                ),
                InkResponse(
                  onTap: context.read(loginNotifier).toggleRememberMe,
                  child: Text(S.of(context).rememberMe),
                )
              ].toRow().padding(right: 16, left: 8),
              SizedBox(height: 32),
              RoundedButton(
                label: S.of(context).login,
              ).constrained(width: 210),
              SizedBox(height: 16),
              RoundedButton(
                label: S.of(context).register,
                backgroundColor: blackColor,
              ).constrained(width: 210),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.black12)),
                child: <Widget>[
                  Image.asset('assets/google_logo.png', height: 24, width: 24),
                  SizedBox(width: 16),
                  Text(
                    S.of(context).loginWithGoogle.toUpperCase(),
                    style: TextStyle(
                      color: blackColor,
                    ),
                  ),
                ].toRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
            ].toColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ).center(),
          bottomNavigationBar: Container(
            child: <Widget>[
              InkResponse(
                onTap: () {
                  context.read(loginNotifier).navigateToHomePage(context);
                },
                child: <Widget>[
                  Text(S.of(context).skipText.toUpperCase()),
                  Icon(Icons.arrow_right_alt_rounded),
                ].toRow(
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
            ]
                .toRow(mainAxisAlignment: MainAxisAlignment.end)
                .padding(horizontal: 16),
          ).parent(({required child}) => SafeArea(child: child)),
        );
      },
    );
  }
}
