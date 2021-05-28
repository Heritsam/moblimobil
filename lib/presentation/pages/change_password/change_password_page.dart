import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import 'steps/new_password.dart';
import 'steps/old_password.dart';
import 'viewmodels/change_password_viewmodel.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(changePasswordViewModel.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          S.of(context).changePassword,
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
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
                    initial: () => OldPassword(),
                    newForm: () => NewPassword(),
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
