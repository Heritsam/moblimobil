import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_button.dart';
import 'viewmodels/change_password/change_password_viewmodel.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _passwordNode = FocusNode();

  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(changePasswordViewModel.notifier).initialize();
    });
  }

  @override
  void dispose() {
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        title: Text(
          S.of(context).changePhoneAndPassword,
          style: textTheme.headline6?.copyWith(color: darkGreyColor),
        ),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
      ),
      body: ProviderListener(
        provider: changePasswordViewModel,
        onChange: (context, ChangePasswordState state) {
          state.maybeWhen(
            success: (message) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            orElse: () {},
          );
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: mediaQuery.padding.top + 56 + 16,
            left: 16,
            right: 16,
            bottom: 32,
          ),
          child: Column(
            children: [
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley',
                textAlign: TextAlign.center,
              ).textColor(darkGreyColor.withOpacity(.70)),
              SizedBox(height: 32),
              Consumer(
                builder: (context, watch, child) {
                  final vm = watch(changePasswordViewModel);

                  return vm.when(
                    initial: () {
                      return <Widget>[
                        <Widget>[
                          Text(
                            S.of(context).enterOldPasswordPhone,
                            textAlign: TextAlign.left,
                          ).fontSize(16).expanded(),
                        ].toRow(mainAxisAlignment: MainAxisAlignment.start),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            hintText: S.of(context).phoneField,
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 18),
                            hintStyle: TextStyle(color: mediumGreyColor),
                          ),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onSubmitted: (_) {
                            _passwordNode.requestFocus();
                          },
                        ).decorated(
                          color: inputFieldColor,
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                        SizedBox(height: 16),
                        <Widget>[
                          TextField(
                            focusNode: _passwordNode,
                            decoration: InputDecoration(
                              hintText: S.of(context).passwordField,
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 18),
                              hintStyle: TextStyle(color: mediumGreyColor),
                            ),
                            obscureText: true,
                          ).expanded(flex: 2),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            icon: Icon(Icons.visibility),
                            color: darkGreyColor,
                          ),
                        ].toRow().decorated(
                              color: inputFieldColor,
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                            ),
                        SizedBox(height: 32),
                        RoundedButton(
                          onPressed: () {
                            context
                                .read(changePasswordViewModel.notifier)
                                .sendOldForm();
                          },
                          label: S.of(context).next,
                          backgroundColor: darkGreyColor,
                        ),
                      ].toColumn();
                    },
                    newForm: () {
                      return <Widget>[
                        <Widget>[
                          Text(
                            S.of(context).enterNewPasswordPhone,
                            textAlign: TextAlign.left,
                          ).fontSize(16).expanded(),
                        ].toRow(mainAxisAlignment: MainAxisAlignment.start),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            hintText: S.of(context).phoneField,
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 18),
                            hintStyle: TextStyle(color: mediumGreyColor),
                          ),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onSubmitted: (_) {
                            _passwordNode.requestFocus();
                          },
                        )
                            .decorated(
                              color: inputFieldColor,
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                              border: Border.all(color: Colors.white),
                            ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            TextField(
                              focusNode: _passwordNode,
                              decoration: InputDecoration(
                                hintText: S.of(context).passwordField,
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 18),
                                hintStyle: TextStyle(color: mediumGreyColor),
                              ),
                              obscureText: true,
                            ).expanded(flex: 2),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                              icon: Icon(Icons.visibility),
                              color: darkGreyColor,
                            ),
                          ],
                        ).decorated(
                          color: inputFieldColor,
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                        SizedBox(height: 32),
                        RoundedButton(
                          onPressed: () {
                            context
                                .read(changePasswordViewModel.notifier)
                                .sendNewForm();
                          },
                          label: S.of(context).send,
                        ),
                      ].toColumn();
                    },
                    success: (message) {
                      return Center(
                        child: Text(message),
                      );
                    },
                    failure: (message) {
                      return Center(
                        child: Text(message),
                      );
                    },
                    loading: () {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
