import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: false,
        elevation: 0,
        leading: BackButton(color: darkGreyColor),
        title: Text(
          S.of(context).notification,
          style: textTheme.headline6?.copyWith(color: darkGreyColor),
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return <Widget>[
            <Widget>[
              Text(
                'Mobil Baru Ditambahkan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                '12/12/2021',
                style: textTheme.caption?.copyWith(color: blueColor),
              ),
            ]
                .toRow(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                )
                .padding(horizontal: 16, top: 16),
            SizedBox(height: 8),
            Text('Lorem ipsum is simply dummy text of printing')
                .padding(horizontal: 16, bottom: 16),
          ]
              .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
              .ripple()
              .backgroundColor(lightGreyColor.withOpacity(.54))
              .gestures(onTap: () {
            Navigator.popUntil(context, ModalRoute.withName('/home'));
            Navigator.pushNamed(context, '/notification-detail');
          }).padding(bottom: 4);
        },
      ),
    );
  }
}
