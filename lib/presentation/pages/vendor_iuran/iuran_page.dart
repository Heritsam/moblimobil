import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_button.dart';

class IuranPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        title: Text(
          S.of(context).iuran,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/iuran-history');
            },
            icon: Icon(Icons.history, color: mediumGreyColor),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 72,
          bottom: mediaQuery.padding.bottom + 32,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Iuran anda selanjutnya',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: mediumGreyColor,
                    fontSize: 16,
                  ),
                ).expanded(flex: 2),
                Text(
                  '12/12/2021',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: greenColor,
                    fontSize: 16,
                  ),
                ).expanded(),
              ],
            )
                .padding(
                  all: 16,
                )
                .decorated(
                  border: Border.all(color: mediumGreyColor, width: 1),
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
            SizedBox(height: 32),
            Text(
              'Iuran bulanan sebesar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rp 123.000',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: greenColor,
                  ),
                ),
                Text(
                  ' / ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: mediumGreyColor,
                  ),
                ),
                Text(
                  '3 Month',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: mediumGreyColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rp 234.000',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: greenColor,
                  ),
                ),
                Text(
                  ' / ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: mediumGreyColor,
                  ),
                ),
                Text(
                  '6 Month',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: mediumGreyColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rp 345.000',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: greenColor,
                  ),
                ),
                Text(
                  ' / ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: mediumGreyColor,
                  ),
                ),
                Text(
                  '12 Month',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: mediumGreyColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              style: TextStyle(color: mediumGreyColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Text(S.of(context).paymentMethod, style: textTheme.headline6),
              ],
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BCA',
                      style: TextStyle(
                        color: blueColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Copy No. Rek',
                      style: TextStyle(
                        color: blueColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Rohayat G. Ade',
                  style: TextStyle(
                    color: darkGreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '0812 3456 7890',
                  style: TextStyle(
                    color: greenColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
                .padding(
                  all: 16,
                )
                .decorated(
                  border: Border.all(width: 1, color: mediumGreyColor),
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
            SizedBox(height: 32),
            RoundedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pay-iuran');
              },
              label: 'Bayar Iuran',
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
