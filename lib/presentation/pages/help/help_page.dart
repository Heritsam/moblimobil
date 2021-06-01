import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_button.dart';
import 'viewmodels/help_viewmodel.dart';

class HelpPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    final vm = watch(helpViewModel);

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
              Column(
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
                        '0822 1353 0065',
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
                        'moblimobil@gmail.com',
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
                        'Jl. Anyelir IV Blok 5W No.4',
                        style: TextStyle(
                          color: blueColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ).expanded()
                    ],
                  ).padding(vertical: 16),
                ],
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
