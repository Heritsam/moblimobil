import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/rounded_button.dart';
import 'notifiers/register_notifier.dart';

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
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, watch, child) {
        final vm = watch(registerNotifier);

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
                SvgPicture.asset(
                  'assets/logo.svg',
                  width: 140,
                  height: 140,
                ),
                SizedBox(height: 32),
                Text(
                  S.of(context).register,
                  style: textTheme.headline6,
                ),
                SizedBox(height: 32),
                TextField(
                  decoration: InputDecoration(
                    hintText: S.of(context).fullNameField,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 18),
                    hintStyle: TextStyle(color: mediumGreyColor),
                  ),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) {
                    _emailNode.requestFocus();
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
                TextField(
                  focusNode: _emailNode,
                  decoration: InputDecoration(
                    hintText: S.of(context).emailField,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 18),
                    hintStyle: TextStyle(color: mediumGreyColor),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) {
                    _phoneNode.requestFocus();
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
                TextField(
                  focusNode: _phoneNode,
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
                    onPressed: context.read(registerNotifier).toggleObscure,
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
                SizedBox(height: 32),
                RoundedButton(
                  onPressed: () {},
                  label: S.of(context).register,
                ).constrained(width: 193),
                SizedBox(height: 16),
                RoundedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: S.of(context).login,
                  backgroundColor: darkGreyColor,
                ).constrained(width: 193),
              ].toColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ).center(),
          ].toStack(alignment: Alignment.bottomCenter),
        );
      },
    );
  }
}
