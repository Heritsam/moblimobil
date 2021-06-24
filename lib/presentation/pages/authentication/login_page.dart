import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_button.dart';
import 'viewmodels/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
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

    return Form(
      key: _formKey,
      child: Scaffold(
        extendBody: true,
        body: Consumer(
          builder: (context, watch, child) {
            final vm = watch(loginViewModel);

            return SingleChildScrollView(
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: S.of(context).emailField,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                  onSaved: (value) {
                    vm.email = value!;
                  },
                  validator: (value) {
                    final emailFormat = RegExp(
                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
                    );

                    if (value!.isEmpty) {
                      return 'Required';
                    }

                    if (!emailFormat.hasMatch(value)) {
                      return 'Enter valid email address';
                    }
                  },
                ).padding(horizontal: 24),
                SizedBox(height: 8),
                TextFormField(
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
                  onSaved: (value) {
                    vm.password = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) return 'Required';
                  },
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
                SizedBox(height: 32),
                if (vm.isLoading)
                  RoundedButton(
                    enabled: false,
                    label: 'LOADING...',
                    elevated: false,
                  ).constrained(width: size.width).padding(horizontal: 24)
                else
                  RoundedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        vm.login(context);
                      }
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
                  onPressed: () {
                    vm.loginWithGoogle(context);
                  },
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
            ).center();
          },
        ),
      ),
    );
  }
}
