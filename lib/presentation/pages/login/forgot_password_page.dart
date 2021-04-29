import 'package:flutter/material.dart';
import 'package:moblimobil/generated/l10n.dart';
import 'package:moblimobil/presentation/widgets/rounded_button.dart';

import '../../../core/theme.dart';
import 'package:styled_widget/styled_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        leading: BackButton(color: blackColor),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: <Widget>[
          SizedBox(height: 56 + mediaQuery.padding.top),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 64),
          TextField(
            decoration: InputDecoration(
              labelText: S.of(context).fullNameField,
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: S.of(context).phoneField,
            ),
          ),
          SizedBox(height: 64),
          RoundedButton(
            onPressed: () {},
            label: S.of(context).save,
          ),
          SizedBox(height: 72 + mediaQuery.padding.top),
        ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
      ).center(),
    );
  }
}
