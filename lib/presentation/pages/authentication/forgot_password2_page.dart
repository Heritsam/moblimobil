import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_button.dart';
import 'viewmodels/forgot_password2_viewmodel.dart';

class ForgotPassword2Args {
  final int userId;

  const ForgotPassword2Args(this.userId);
}

class ForgotPassword2Page extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final args = ModalRoute.of(context)!.settings.arguments as ForgotPassword2Args;

    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    final vm = watch(forgotPassword2ViewModel);

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
              S.of(context).changePassword,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: darkGreyColor,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 32),
            Text(
              S.of(context).changePasswordMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 64),
            TextFormField(
              decoration: InputDecoration(
                labelText: S.of(context).enterNewPasswordPhone,
              ),
              obscureText: vm.isObscured,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required';
                }
              },
              onSaved: (value) {
                vm.newPassword = value!;
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
                    vm.submit(context, args.userId);
                  }
                },
                label: S.of(context).confirm.toUpperCase(),
                elevated: false,
              ).constrained(width: size.width),
            SizedBox(height: 72 + mediaQuery.padding.top),
          ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
        ).center(),
      ),
    );
  }
}
