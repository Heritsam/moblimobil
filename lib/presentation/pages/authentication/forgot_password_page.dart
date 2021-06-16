import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_button.dart';
import 'viewmodels/forgot_password_viewmodel.dart';

class ForgotPasswordPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    final vm = watch(forgotPasswordViewModel);

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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
            TextFormField(
              decoration: InputDecoration(
                labelText: S.of(context).emailField,
              ),
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
              onSaved: (value) {
                vm.email = value!;
              },
            ),
            SizedBox(height: 64),
            if (vm.isLoading)
            RoundedButton(
              label: 'LOADING...',
              enabled: false,
              elevated: false,
            ).constrained(width: size.width)
            else
            RoundedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  vm.submit(context);
                }
              },
              label: S.of(context).send.toUpperCase(),
              elevated: false,
            ).constrained(width: size.width),
            SizedBox(height: 72 + mediaQuery.padding.top),
          ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
        ).center(),
      ),
    );
  }
}
