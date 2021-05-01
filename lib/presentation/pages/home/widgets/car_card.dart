import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moblimobil/presentation/notifiers/app_settings/app_settings_notifier.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/theme.dart';
import '../../../../generated/l10n.dart';

class CarCard extends StatefulWidget {
  final String title;
  final int? originalPrice;
  final int price;
  final String imageUrl;
  final bool hasUsed;
  final Function()? onTap;

  const CarCard({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.originalPrice,
    this.hasUsed = false,
    this.onTap,
  }) : super(key: key);

  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final width = 220.0;

    return Consumer(
      builder: (context, watch, child) {
        final settings = watch(appSettingsNotifier);

        return Styled.widget(
          child: <Widget>[
            <Widget>[
              Container(
                height: 120,
                width: width,
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (widget.hasUsed)
                Styled.text(
                  S.of(context).usedText,
                  style: TextStyle(
                    color: redColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                )
                    .padding(horizontal: 16, vertical: 6)
                    .backgroundColor(Colors.white54)
                    .backgroundBlur(20)
                    .clipRRect(
                      topRight: 150,
                      bottomRight: 150,
                    )
                    .padding(bottom: 16),
            ].toStack(alignment: Alignment.bottomLeft),
            SizedBox(height: 10),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: darkGreyColor,
              ),
              overflow: TextOverflow.ellipsis,
            ).padding(horizontal: 8).constrained(width: width),
            SizedBox(height: 4),
            <Widget>[
              <Widget>[
                if (widget.originalPrice != null)
                  Text(
                    NumberFormat.compactCurrency(
                      locale: settings.language,
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(widget.originalPrice),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ).padding(left: 8).constrained(width: width),
                if (widget.originalPrice != null) SizedBox(height: 4),
                Text(
                  NumberFormat.compactCurrency(
                    locale: settings.language,
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(widget.price),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(color: greenColor),
                ).padding(left: 8)
              ]
                  .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
                  .expanded(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite),
                iconSize: 32,
                color: Colors.black12,
                padding: EdgeInsets.only(right: 8),
              ),
            ]
                .toRow(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                )
                .constrained(width: width),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        )
            .borderRadius(all: defaultBorderRadius)
            .ripple()
            .backgroundColor(Colors.white, animate: true)
            .clipRRect(all: defaultBorderRadius)
            .borderRadius(all: defaultBorderRadius, animate: true)
            .elevation(
              _isPressed ? 2 : 10,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              shadowColor: Colors.black26,
            )
            .gestures(
              onTapChange: (tapStatus) =>
                  setState(() => _isPressed = tapStatus),
              onTap: widget.onTap,
            )
            .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
            .animate(
                Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
      },
    );
  }
}
