import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_button.dart';
import 'viewmodels/register_viewmodel.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
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

    return Form(
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          flexibleSpace: ClipRRect(
            child: Container(color: Colors.white60).backgroundBlur(7),
          ),
          leading: BackButton(color: darkGreyColor),
        ),
        body: Consumer(
          builder: (context, watch, child) {
            final vm = watch(registerViewModel);

            return SingleChildScrollView(
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
                // FullName
                TextFormField(
                  decoration: InputDecoration(
                    labelText: S.of(context).fullNameField,
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    vm.fullname = value;
                    FocusScope.of(context).requestFocus(_emailNode);
                  },
                  onSaved: (value) {
                    vm.fullname = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) return 'Required';
                  },
                ).padding(horizontal: 24),
                SizedBox(height: 8),
                // Email
                TextFormField(
                  focusNode: _emailNode,
                  decoration: InputDecoration(
                    labelText: S.of(context).emailField,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_phoneNode);
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
                // Phone
                TextFormField(
                  focusNode: _phoneNode,
                  decoration: InputDecoration(
                    labelText: S.of(context).phoneField,
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                  onSaved: (value) {
                    vm.phone = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) return 'Required';
                  },
                ).padding(horizontal: 24),
                SizedBox(height: 8),
                // Password
                TextFormField(
                  focusNode: _passwordNode,
                  decoration: InputDecoration(
                    labelText: S.of(context).passwordField,
                  ),
                  obscureText: vm.isObscured,
                  onSaved: (value) {
                    vm.password = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) return 'Required';
                  },
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
                        vm.register(context);
                      }
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
                      Text(S.of(context).loginWithGoogle.toUpperCase())
                          .textColor(Colors.black),
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
            ).center();
          },
        ),
      ),
    );
  }
}
