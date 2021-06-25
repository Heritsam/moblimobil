import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../notifiers/about/about_notifier.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/error/empty_state.dart';
import 'viewmodels/help_viewmodel.dart';

class HelpPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    final vm = watch(helpViewModel);
    final about = watch(aboutNotifier);

    return Form(
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white70,
          elevation: 0,
          centerTitle: false,
          title: Text(
            S.of(context).help,
            style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
          ),
          flexibleSpace: ClipRRect(
            child: Container(color: Colors.white60).backgroundBlur(7),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: mediaQuery.padding.top + 56 + 16,
            left: 16,
            right: 16,
            bottom: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: S.of(context).fullNameField,
                ),
                onSaved: (value) {
                  vm.fullname = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) return 'Required';
                },
              ),
              SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                  hintText: S.of(context).textField,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(mediumBorderRadius),
                  ),
                ),
                maxLines: 5,
                onSaved: (value) {
                  vm.description = value!;
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
                  horizontalPadding: 52,
                )
              else
                RoundedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      vm.sendHelp(context);
                    }
                  },
                  label: S.of(context).send,
                  horizontalPadding: 52,
                ),
              SizedBox(height: 32),
              Text(
                S.of(context).otherHelpMessage,
                textAlign: TextAlign.center,
              ).textColor(darkGreyColor.withOpacity(.70)),
              SizedBox(height: 32),
              about.aboutState
                  .when(
                    initial: () {
                      return Center(child: CircularProgressIndicator());
                    },
                    loading: () {
                      return Center(child: CircularProgressIndicator());
                    },
                    error: (message) {
                      return EmptyState(
                        onPressed: about.fetch,
                        message: message,
                      );
                    },
                    data: (item) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                color: mediumGreyColor,
                                size: 28,
                              ),
                              SizedBox(width: 16),
                              Text(
                                item.formattedPhone,
                                style: TextStyle(
                                  color: blueColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ).expanded()
                            ],
                          ).padding(vertical: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.mail_outline_rounded,
                                color: mediumGreyColor,
                                size: 28,
                              ),
                              SizedBox(width: 16),
                              Text(
                                item.email,
                                style: TextStyle(
                                  color: blueColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ).expanded()
                            ],
                          ).padding(vertical: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.map_rounded,
                                color: mediumGreyColor,
                                size: 28,
                              ),
                              SizedBox(width: 16),
                              Text(
                                item.address,
                                style: TextStyle(
                                  color: blueColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ).expanded()
                            ],
                          ).padding(vertical: 16),
                        ],
                      );
                    },
                  )
                  .padding(all: 16)
                  .decorated(
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    border: Border.all(color: mediumGreyColor),
                  )
                  .constrained(width: size.width),
            ],
          ),
        ).gestures(onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        }),
      ),
    );
  }
}
