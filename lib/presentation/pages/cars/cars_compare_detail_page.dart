import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/product/product.dart';
import '../../notifiers/app_settings/app_settings_notifier.dart';
import 'viewmodels/car_compare_viewmodel.dart';

class CarsCompareDetailPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final settings = watch(appSettingsNotifier);
    final vm = watch(carCompareViewModel);
    final mediaQuery = MediaQuery.of(context);
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
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: mediaQuery.padding.top + 72),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 8),
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: vm.selectedCars.length,
          itemBuilder: (context, index) {
            final item = vm.selectedCars[index];

            return _buildCar(
              context,
              item: item,
              width: width,
              settings: settings,
            ).padding(bottom: mediaQuery.padding.bottom + 24);
          },
        ).constrained(height: 820),
      ),
    );
  }

  Widget _buildCar(
    BuildContext context, {
    required Product item,
    required double width,
    required AppSettingsNotifier settings,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Styled.widget()
            .decorated(
              color: lightGreyColor,
              image: DecorationImage(
                image: NetworkImage(
                  item.file.isNotEmpty
                      ? item.file.first.file
                      : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                ),
                fit: BoxFit.cover,
              ),
            )
            .clipRRect(
              topRight: mediumBorderRadius,
              topLeft: mediumBorderRadius,
            )
            .constrained(height: 140, width: width),
        Text(
          '${item.brandName} ${item.title}',
          style: TextStyle(
            color: darkGreyColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
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
              ).format(int.tryParse(item.price) ?? 0),
              style: TextStyle(color: blueColor, fontWeight: FontWeight.w600),
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
              item.brandName.toUpperCase(),
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
              item.fuelTypeName.toUpperCase(),
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
              item.transmissionName.toUpperCase(),
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
              item.yearProduct,
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
              '${item.kilometer} km',
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
              item.colorName,
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
          borderRadius: BorderRadius.circular(mediumBorderRadius),
        )
        .elevation(
          10,
          borderRadius: BorderRadius.circular(mediumBorderRadius),
          shadowColor: Colors.black38,
        )
        .padding(horizontal: 8);
  }
}
