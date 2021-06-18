import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/bank/bank.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/cars/price_chip.dart';
import '../account/viewmodels/account_user_notifier.dart';
import 'viewmodels/pay_iuran_viewmodels.dart';

class PayIuranPage extends StatefulWidget {
  @override
  _PayIuranPageState createState() => _PayIuranPageState();
}

class _PayIuranPageState extends State<PayIuranPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(payIuranViewModels).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return Form(
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          centerTitle: false,
          flexibleSpace: ClipRRect(
            child: Container(color: Colors.white60).backgroundBlur(7),
          ),
          title: Text(
            S.of(context).iuran,
            style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
          ),
        ),
        body: Consumer(
          builder: (context, watch, child) {
            final userState = watch(accountUserNotifier);
            final vm = watch(payIuranViewModels);

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: mediaQuery.padding.top + 72,
                bottom: mediaQuery.padding.bottom + 64,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: S.of(context).fullNameField,
                    ),
                    initialValue: userState.userState.maybeWhen(
                      data: (user) => user.fullname,
                      orElse: () => vm.fullname,
                    ),
                    onSaved: (value) {
                      vm.fullname = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Required';
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  DropdownSearch<Bank>(
                    mode: Mode.BOTTOM_SHEET,
                    onChanged: vm.chooseBank,
                    enabled: vm.bankState.maybeWhen(
                      data: (_) => true,
                      orElse: () => false,
                    ),
                    items: vm.bankState.maybeWhen(
                      data: (data) => data,
                      orElse: () => [],
                    ),
                    itemAsString: (item) => item.title,
                    dropdownSearchDecoration: InputDecoration(
                      labelText: 'Bank',
                      contentPadding: EdgeInsets.zero,
                    ),
                    emptyBuilder: (context, message) {
                      return Scaffold(
                        body: Text('No Data Found').center(),
                      );
                    },
                    validator: (value) {
                      if (value == null) return 'Required';
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'No. Rekening',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    initialValue: vm.accountNumber,
                    onSaved: (value) {
                      vm.accountNumber = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Required';
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nominal',
                      prefixText: 'Rp ',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onSaved: (value) {
                      vm.nominal = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Required';
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      PriceChip(
                        onTap: () {
                          vm.changeType('3_month');
                        },
                        selected: vm.type == '3_month',
                        activeColor: greenColor,
                        label: '3 Month',
                      ).expanded(),
                      SizedBox(width: 16),
                      PriceChip(
                        onTap: () {
                          vm.changeType('6_month');
                        },
                        selected: vm.type == '6_month',
                        activeColor: greenColor,
                        label: '6 Month',
                      ).expanded(),
                      SizedBox(width: 16),
                      PriceChip(
                        onTap: () {
                          vm.changeType('12_month');
                        },
                        selected: vm.type == '12_month',
                        activeColor: greenColor,
                        label: '12 Month',
                      ).expanded(),
                    ],
                  ).padding(horizontal: 16),
                  SizedBox(height: 32),
                  Text(
                    'Upload Photo',
                    style: textTheme.headline6,
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  if (vm.file != null)
                    Container(
                      width: mediaQuery.size.width,
                      child: SizedBox(height: 80),
                      padding: EdgeInsets.all(64),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: lightGreyColor.withOpacity(.70),
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                        image: DecorationImage(
                          image: FileImage(vm.file!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).gestures(onTap: () => vm.peekImage(context))
                  else
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 80,
                      color: mediumGreyColor,
                    )
                        .padding(all: 64)
                        .decorated(
                          color: lightGreyColor.withOpacity(.70),
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        )
                        .constrained(width: mediaQuery.size.width)
                        .padding(horizontal: 16)
                        .gestures(onTap: vm.pickImage),
                  SizedBox(height: 48),
                  if (vm.isLoading)
                    RoundedButton(
                      enabled: false,
                      elevated: false,
                      label: 'Loading...',
                      horizontalPadding: 32,
                    ).center()
                  else
                    RoundedButton(
                      onPressed: () {
                        if (vm.file == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Upload bukti')));
                          return;
                        }

                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          vm.submit(context);
                        }
                      },
                      label: 'Upload',
                      horizontalPadding: 32,
                    ).center(),
                  SizedBox(height: mediaQuery.padding.bottom + 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
