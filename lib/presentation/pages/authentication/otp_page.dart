import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/auth/email_not_verified.dart';
import '../../widgets/buttons/rounded_button.dart';
import 'viewmodels/otp_viewmodel.dart';

class OtpArgs {
  final EmailNotVerified args;

  const OtpArgs(this.args);
}

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  late OtpArgs args;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as OtpArgs;
      context.read(otpViewModel).userId = args.args.userId;
      context.read(otpViewModel).password = args.args.password;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    args = ModalRoute.of(context)!.settings.arguments as OtpArgs;

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
            final vm = watch(otpViewModel);

            return SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: <Widget>[
                SizedBox(height: mediaQuery.padding.top + 56),
                Image.asset(
                  'assets/illustration_user.png',
                  width: 140,
                  height: 140,
                ),
                SizedBox(height: 16),
                Text(
                  'Hi... ${args.args.fullname}',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: darkGreyColor,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 32),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Please confirm that '),
                      TextSpan(text: args.args.email)
                          .fontWeight(FontWeight.w600),
                      TextSpan(
                        text:
                            ' is you with enter the code we sent to your email.',
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ).padding(horizontal: 16),
                SizedBox(height: 32),
                PinCodeTextField(
                  appContext: context,
                  length: 5,
                  onChanged: (value) {
                    vm.token = value;
                  },
                  animationType: AnimationType.none,
                  mainAxisAlignment: MainAxisAlignment.center,
                  pinTheme: PinTheme(
                    selectedColor: blueColor,
                    inactiveColor: Colors.black,
                    borderWidth: 1,
                    fieldOuterPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value!.isEmpty) return 'Required';
                  },
                ).padding(),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).notReceiveCode).textColor(darkGreyColor),
                    InkResponse(
                      onTap: () {},
                      child: Text(S.of(context).resendCode)
                          .fontWeight(FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 64),
                if (vm.isLoading)
                  RoundedButton(
                    enabled: false,
                    label: 'LOADING...',
                  ).constrained(width: size.width)
                else
                  RoundedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        vm.checkToken(context);
                      }
                    },
                    label: S.of(context).confirm.toUpperCase(),
                    elevated: false,
                  ).constrained(width: size.width),
              ]
                  .toColumn(crossAxisAlignment: CrossAxisAlignment.center)
                  .center(),
            );
          },
        ),
      ),
    );
  }
}
