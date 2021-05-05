import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../notifiers/app_settings/app_settings_notifier.dart';
import 'viewmodels/car_compare_viewmodel.dart';

class CarsCompareDetailPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final settings = watch(appSettingsNotifier);
    final vm = watch(carCompareViewModel);
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final width = 200.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        title: Text(
          S.of(context).compare,
          style: textTheme.headline6?.copyWith(color: darkGreyColor),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: vm.selectedCars.length,
        itemBuilder: (context, index) {
          final item = vm.selectedCars[index];

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: mediaQuery.padding.top + 56 + 16,
              bottom: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Styled.widget()
                    .decorated(
                      color: lightGreyColor,
                      image: DecorationImage(
                        image: NetworkImage(item.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    )
                    .clipRRect(
                      topRight: defaultBorderRadius,
                      topLeft: defaultBorderRadius,
                    )
                    .constrained(height: 140, width: width),
                Text(
                  item.title,
                  style: TextStyle(
                    color: darkGreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
                    .padding(all: 16)
                    .backgroundColor(lighterGreyColor)
                    .constrained(width: width),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).price,
                      style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      NumberFormat.currency(
                        decimalDigits: 0,
                        locale: settings.language,
                        symbol: 'Rp ',
                      ).format(item.price),
                      style: TextStyle(color: greenColor),
                    ),
                  ],
                ).padding(all: 16).constrained(width: width),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).brand,
                      style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item.brand.toUpperCase(),
                      style: TextStyle(
                        color: darkGreyColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                )
                    .padding(all: 16)
                    .backgroundColor(lighterGreyColor)
                    .constrained(width: width),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).fuelType,
                      style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item.fuelType.toUpperCase(),
                      style: TextStyle(
                        color: darkGreyColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ).padding(all: 16).constrained(width: width),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).transmission,
                      style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'MATIC',
                      style: TextStyle(
                        color: darkGreyColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                )
                    .padding(all: 16)
                    .backgroundColor(lighterGreyColor)
                    .constrained(width: width),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).year,
                      style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '2016',
                      style: TextStyle(
                        color: darkGreyColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ).padding(all: 16).constrained(width: width),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).kilometers,
                      style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '299000 km',
                      style: TextStyle(
                        color: darkGreyColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                )
                    .padding(all: 16)
                    .backgroundColor(lighterGreyColor)
                    .constrained(width: width),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).color,
                      style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item.color,
                      style: TextStyle(
                        color: darkGreyColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ).padding(all: 16).constrained(width: width),
              ],
            )
                .decorated(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                )
                .elevation(
                  10,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  shadowColor: Colors.black38,
                )
                .padding(horizontal: 8),
          );
        },
      ),
    );
  }
}
