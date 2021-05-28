import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../widgets/mobli_card.dart';

class IuranHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          'History',
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 72,
          bottom: mediaQuery.padding.bottom + 64,
          left: 16,
          right: 16,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: MobliCard(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Styled.widget()
                      .decorated(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://1.bp.blogspot.com/-MOHGve9IHeQ/XHvEjRpgyhI/AAAAAAAAIyQ/06yF5OyDDHQEwAqbc9SnzW7Sq0rx_RMdwCLcBGAs/s1600/IMG_20181120_064248_565.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                      )
                      .constrained(height: 120, width: 120),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pembayaran 3 Bulan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '12/12/2021',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: redColor,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'BCA',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: blueColor,
                        ),
                      ),
                      Text(
                        'Rohayat G. Ade',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Rp 123.000',
                        style: TextStyle(
                          color: greenColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ).expanded(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
