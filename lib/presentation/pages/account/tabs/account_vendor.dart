import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/mobli_icons_icons.dart';
import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/account/dashboard_item.dart';
import '../../../widgets/circle_image.dart';
import '../../../widgets/mobli_card.dart';

class AccountVendor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MobliCard(
                    onTap: () {},
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Sold',
                          style: TextStyle(color: mediumGreyColor),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '9',
                          style: TextStyle(
                            fontSize: 30,
                            color: greenColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ).expanded(),
                  SizedBox(width: 16),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      MobliCard(
                        onTap: () {},
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              'Test Drive',
                              style: TextStyle(color: mediumGreyColor),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '12',
                              style: TextStyle(
                                fontSize: 30,
                                color: greenColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ).constrained(width: mediaQuery.size.width),
                      Container(
                        child: Text('3').fontSize(12).textColor(Colors.white),
                        padding: EdgeInsets.all(6),
                        margin: EdgeInsets.only(right: 8, top: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: redColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 6,
                              offset: Offset(0, 3),
                              color: redColor.withOpacity(.38),
                            ),
                          ],
                        ),
                      )
                    ],
                  ).expanded(),
                ],
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MobliCard(
                    onTap: () {},
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          S.of(context).cars,
                          style: TextStyle(color: mediumGreyColor),
                        ),
                        SizedBox(height: 2),
                        Icon(MobliIcons.car_alt, color: greenColor, size: 64),
                      ],
                    ),
                  ).expanded(),
                  SizedBox(width: 16),
                  MobliCard(
                    onTap: () {},
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          S.of(context).iuran,
                          style: TextStyle(color: mediumGreyColor),
                        ),
                        SizedBox(height: 2),
                        Icon(MobliIcons.iuran, color: greenColor, size: 64),
                      ],
                    ),
                  ).constrained(width: mediaQuery.size.width).expanded(),
                ],
              ),
            ],
          ),
          SizedBox(height: mediaQuery.padding.bottom),
        ],
      ),
    );
  }
}
