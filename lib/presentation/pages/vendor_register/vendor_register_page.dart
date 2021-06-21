import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../widgets/buttons/rounded_button.dart';
import 'viewmodels/vendor_register_viewmodel.dart';

class VendorRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final vm = watch(vendorRegisterViewModel);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/illustration_user.png',
                width: 140,
                height: 140,
              ),
              SizedBox(height: 16),
              Text(
                'Hi...',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: darkGreyColor,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 58),
              Text(
                'Selamat datang Seller\nKamu bisa jual mobil bekas / Baru kamu\ndisini, Klik tombol di bawah untuk\nmeminta akses sebagai seller.',
                textAlign: TextAlign.center,
              ).padding(horizontal: 24),
              SizedBox(height: 64),
              if (vm.isLoading)
                RoundedButton(
                  label: 'LOADING...',
                  enabled: false,
                  elevated: false,
                ).constrained(width: size.width)
              else
                RoundedButton(
                  onPressed: () {
                    vm.submit(context);
                  },
                  label: 'Daftar Sebagai Seller'.toUpperCase(),
                  elevated: false,
                ).constrained(width: size.width),
              SizedBox(height: 16),
            ],
          ).padding(all: 24).center();
        },
      ),
    );
  }
}
