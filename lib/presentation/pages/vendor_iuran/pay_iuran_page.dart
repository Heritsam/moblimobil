import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/cars/price_chip.dart';

class PayIuranPage extends StatefulWidget {
  @override
  _PayIuranPageState createState() => _PayIuranPageState();
}

class _PayIuranPageState extends State<PayIuranPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

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
          S.of(context).iuran,
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 72,
          bottom: mediaQuery.padding.bottom + 64,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: S.of(context).fullNameField,
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: ['BCA', 'Mandiri', 'BRI'],
              dropdownSearchDecoration: InputDecoration(
                labelText: 'Bank',
                contentPadding: EdgeInsets.zero,
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'No. Rekening',
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nominal',
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 24),
            Row(
              children: [
                PriceChip(
                  selected: true,
                  activeColor: greenColor,
                  label: '3 Month',
                ).expanded(),
                SizedBox(width: 16),
                PriceChip(
                  activeColor: greenColor,
                  label: '6 Month',
                ).expanded(),
                SizedBox(width: 16),
                PriceChip(
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
            Icon(Icons.camera_alt_outlined, size: 80, color: mediumGreyColor)
                .padding(all: 64)
                .decorated(
                  color: lightGreyColor.withOpacity(.70),
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ).constrained(width: mediaQuery.size.width)
                .padding(horizontal: 16),
            SizedBox(height: 48),
            RoundedButton(
              label: 'Upload',
              horizontalPadding: 32,
            ).center(),
            SizedBox(height: mediaQuery.padding.bottom + 32),
          ],
        ),
      ),
    );
  }
}
