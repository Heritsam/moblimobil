import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/rounded_button.dart';
import '../viewmodels/new_password_notifier.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(newPasswordNotifier).isLoading = false;
      context.read(newPasswordNotifier).isObscured = true;
      context.read(newPasswordNotifier).newPassword = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer(
        builder: (context, watch, child) {
          final vm = watch(newPasswordNotifier);

          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    S.of(context).enterNewPasswordPhone,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ).expanded(),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: S.of(context).passwordField,
                  suffixIcon: IconButton(
                    onPressed: vm.toggleObscure,
                    icon: Icon(vm.isObscured
                        ? Icons.visibility
                        : Icons.visibility_off),
                    color: darkGreyColor,
                  ),
                ),
                obscureText: vm.isObscured,
                onSaved: (value) {
                  vm.newPassword = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) return 'Required';
                },
              ),
              SizedBox(height: 32),
              if (vm.isLoading)
                RoundedButton(
                  enabled: false,
                  label: 'LOADING...',
                  horizontalPadding: 64,
                )
              else
                RoundedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      vm.updatePassword(context);
                    }
                  },
                  label: S.of(context).send,
                  horizontalPadding: 64,
                ),
            ],
          );
        },
      ),
    );
  }
}
