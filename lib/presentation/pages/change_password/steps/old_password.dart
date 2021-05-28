import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/rounded_button.dart';
import '../viewmodels/change_password_viewmodel.dart';

class OldPassword extends StatefulWidget {
  @override
  _OldPasswordState createState() => _OldPasswordState();
}

class _OldPasswordState extends State<OldPassword> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).enterOldPasswordPhone,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ).expanded(),
          ],
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: S.of(context).passwordField,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
              icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
              color: darkGreyColor,
            ),
          ),
          obscureText: _isObscured,
        ),
        SizedBox(height: 32),
        RoundedButton(
          onPressed: () {
            context.read(changePasswordViewModel.notifier).sendOldForm();
          },
          label: S.of(context).next,
          backgroundColor: darkGreyColor,
          horizontalPadding: 64,
        ),
      ],
    );
  }
}
