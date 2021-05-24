import 'package:dropdown_search/dropdown_search.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../notifiers/app_settings/app_settings_notifier.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/seller_card.dart';

class TestDrive extends StatefulWidget {
  @override
  _TestDriveState createState() => _TestDriveState();
}

class _TestDriveState extends State<TestDrive> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, watch, child) {
        final settings = watch(appSettingsNotifier);

        return Dialog(
          insetPadding: EdgeInsets.all(16),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                    color: mediumGreyColor,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              FadingEdgeScrollView.fromSingleChildScrollView(
                shouldDisposeScrollController: true,
                child: SingleChildScrollView(
                  controller: _controller,
                  child: <Widget>[
                    SellerCard(
                      name: 'Verdiansyah',
                      phone: '0812 3456 7890',
                      avatar: NetworkImage(
                        'https://uifaces.co/our-content/donated/6MWH9Xi_.jpg',
                      ),
                    ).padding(horizontal: 16).constrained(width: size.width),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Styled.widget()
                            .decorated(
                              color: lightGreyColor,
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                              image: DecorationImage(
                                image: NetworkImage(carList[5].imageUrl),
                                fit: BoxFit.cover,
                              ),
                            )
                            .constrained(height: 87, width: 87),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ferrari Heritsa', style: textTheme.headline6),
                            SizedBox(height: 2),
                            Text(
                              'Used',
                              style: TextStyle(color: redColor),
                            ),
                            SizedBox(height: 8),
                            Text(
                              NumberFormat.currency(
                                locale: settings.language,
                                symbol: 'Rp ',
                                decimalDigits: 0,
                              ).format(125000000),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              NumberFormat.currency(
                                locale: settings.language,
                                symbol: 'Rp ',
                                decimalDigits: 0,
                              ).format(125000000),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: greenColor),
                            ),
                          ],
                        ).expanded(),
                      ],
                    ).padding(horizontal: 16),
                    SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        labelText: S.of(context).fullNameField,
                      ),
                    ).padding(horizontal: 16),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: S.of(context).emailField,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ).padding(horizontal: 16),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: S.of(context).phoneField,
                      ),
                      keyboardType: TextInputType.phone,
                    ).padding(horizontal: 16),
                    SizedBox(height: 16),
                    DropdownSearch(
                      mode: Mode.BOTTOM_SHEET,
                      items: [
                        'COD',
                        'Cash on Delivery',
                        'Cash OD',
                        'C on Delivery'
                      ],
                      dropdownSearchDecoration: InputDecoration(
                        labelText: S.of(context).paymentMethod,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ).padding(horizontal: 16),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).date,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 4),
                            DropdownSearch(
                              mode: Mode.BOTTOM_SHEET,
                              items: [''],
                              dropdownSearchDecoration: InputDecoration(
                                hintText: S.of(context).date,
                                hintStyle: TextStyle(color: mediumGreyColor),
                                contentPadding: EdgeInsets.only(left: 16),
                                border: InputBorder.none,
                              ),
                            ).decorated(
                              color: lightGreyColor.withOpacity(.54),
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                            )
                          ],
                        ).expanded(),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).time,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 4),
                            DropdownSearch(
                              mode: Mode.BOTTOM_SHEET,
                              items: [''],
                              dropdownSearchDecoration: InputDecoration(
                                hintText: S.of(context).time,
                                hintStyle: TextStyle(color: mediumGreyColor),
                                contentPadding: EdgeInsets.only(left: 16),
                                border: InputBorder.none,
                              ),
                            ).decorated(
                              color: lightGreyColor.withOpacity(.54),
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                            )
                          ],
                        ).expanded(),
                      ],
                    ).padding(horizontal: 16),
                    SizedBox(height: 24),
                  ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                ),
              ).expanded(),
              RoundedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: S.of(context).scheduleToTestDrive,
                verticalPadding: 12,
                horizontalPadding: 0,
              ).padding(all: 16).constrained(width: size.width),
            ],
          ),
        );
      },
    );
  }
}
