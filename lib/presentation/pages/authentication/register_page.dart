import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_button.dart';
import 'viewmodels/register_viewmodels.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailNode = FocusNode();
  final _phoneNode = FocusNode();
  final _passwordNode = FocusNode();

  @override
  void dispose() {
    _emailNode.dispose();
    _phoneNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Consumer(
      builder: (context, watch, child) {
        final vm = watch(registerViewModel);

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
            padding: EdgeInsets.symmetric(vertical: 24),
            child: <Widget>[
              SizedBox(height: 56),
              Image.asset(
                'assets/illustration_user.png',
                width: 140,
                height: 140,
              ),
              SizedBox(height: 16),
              Text(
                S.of(context).register,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: darkGreyColor,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(
                  labelText: S.of(context).fullNameField,
                ),
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailNode);
                },
              ).padding(horizontal: 24),
              SizedBox(height: 8),
              TextField(
                focusNode: _emailNode,
                decoration: InputDecoration(
                  labelText: S.of(context).emailField,
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_phoneNode);
                },
              ).padding(horizontal: 24),
              SizedBox(height: 8),
              TextField(
                focusNode: _phoneNode,
                decoration: InputDecoration(
                  labelText: S.of(context).phoneField,
                ),
                keyboardType: TextInputType.phone,
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
                ),
                obscureText: vm.isObscured,
              ).padding(horizontal: 24),
              SizedBox(height: 32),
              RoundedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/otp');
                },
                label: S.of(context).register.toUpperCase(),
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
                    Text(S.of(context).loginWithGoogle.toUpperCase()).textColor(Colors.black),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ).constrained(width: size.width).padding(horizontal: 24),
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
