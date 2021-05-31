import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/mobli_icons_icons.dart';
import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/circle_image.dart';
import '../../../widgets/mobli_card.dart';

class AccountVendor extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: mediaQuery.padding.top + 16,
        right: 16,
        left: 16,
        bottom: mediaQuery.padding.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleImage(
                    size: 120,
                    image: NetworkImage(
                        'https://uifaces.co/our-content/donated/gPZwCbdS.jpg'),
                  ),
                  Icon(Icons.verified, size: 18, color: yellowColor)
                      .padding(all: 4)
                      .backgroundColor(Colors.white)
                      .clipOval()
                      .elevation(
                        8,
                        borderRadius: BorderRadius.circular(150),
                        shadowColor: Colors.black26,
                      )
                      .alignment(Alignment.topRight)
                      .padding(top: 4, right: 4),
                ],
              ).constrained(height: 120, width: 120),
              SizedBox(height: 16),
              Text(
                'Rohayat G. Ade',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: darkGreyColor,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                '0822 1353 0065',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: greenColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              MobliCard(
                onTap: () {
                  Navigator.pushNamed(context, '/vendor-cars');
                },
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(MobliIcons.car_alt, color: greenColor, size: 64),
                    SizedBox(width: 16),
                    Text(
                      S.of(context).cars,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: darkGreyColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '12',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              SizedBox(height: 16),
              MobliCard(
                onTap: () {
                  Navigator.pushNamed(context, '/vendor-sold');
                },
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(MobliIcons.sold, color: greenColor, size: 64),
                    SizedBox(width: 16),
                    Text(
                      S.of(context).sold,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: darkGreyColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '9',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              SizedBox(height: 16),
              MobliCard(
                onTap: () {
                  Navigator.pushNamed(context, '/iuran');
                },
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(MobliIcons.iuran, color: greenColor, size: 64),
                    SizedBox(width: 16),
                    Text(
                      S.of(context).iuran,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: darkGreyColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      NumberFormat.compactCurrency(
                        locale: 'en',
                        decimalDigits: 0,
                        symbol: 'Rp ',
                      ).format(123000) + '/' + S.of(context).month,
                      style: TextStyle(
                        color: mediumGreyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: mediaQuery.padding.bottom),
        ],
      ),
    );
  }
}
