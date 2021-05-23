import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';

class CarCard extends StatefulWidget {
  final int carId;
  final String title;
  final int price;
  final String imageUrl;
  final bool hasUsed;
  final double size;
  final Function()? onTap;

  const CarCard({
    Key? key,
    required this.carId,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.hasUsed = false,
    this.size = 160.0,
    this.onTap,
  }) : super(key: key);

  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final width = widget.size;

    return Consumer(
      builder: (context, watch, child) {
        return Column(
          children: [
            Stack(
              children: [
                Container(
                  height: width,
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
                  Text(
                    S.of(context).usedText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                      .padding(horizontal: 8, vertical: 6)
                      .backgroundColor(redColor)
                      .clipRRect(
                        topRight: 150,
                        bottomRight: 150,
                      )
                      .padding(top: 16),
              ],
            )
                .borderRadius(all: mediumBorderRadius)
                .ripple()
                .clipRRect(all: mediumBorderRadius)
                .borderRadius(all: mediumBorderRadius, animate: true)
                .elevation(
                  _isPressed ? 2 : 10,
                  borderRadius: BorderRadius.circular(mediumBorderRadius),
                  shadowColor: Colors.black26,
                )
                .gestures(
                  onTapChange: (tapStatus) =>
                      setState(() => _isPressed = tapStatus),
                  onTap: widget.onTap,
                )
                .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
                .animate(
                    Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn),
            SizedBox(height: 8),
            Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: darkGreyColor,
              ),
            ).constrained(width: width),
            SizedBox(height: 2),
            Text(
              NumberFormat.currency(
                locale: 'id',
                decimalDigits: 0,
                symbol: 'Rp ',
              ).format(widget.price),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w600, color: blueColor),
            ).constrained(width: width),
          ],
        );
      },
    );
  }
}
