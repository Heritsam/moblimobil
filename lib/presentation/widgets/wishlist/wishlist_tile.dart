import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';

class WishlistTile extends StatefulWidget {
  final String title;
  final int price;
  final Widget subtitle;
  final String imageUrl;
  final Function()? onTap;

  const WishlistTile({
    Key? key,
    required this.title,
    required this.price,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  _WishlistTile createState() => _WishlistTile();
}

class _WishlistTile extends State<WishlistTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = 140.0;

    return Consumer(
      builder: (context, watch, child) {
        return Row(
          children: [
            Container(
              height: 90,
              width: width,
              decoration: BoxDecoration(
                color: lightGreyColor,
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ).clipRRect(all: mediumBorderRadius),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: darkGreyColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      NumberFormat.currency(
                        locale: 'id',
                        decimalDigits: 0,
                        symbol: 'Rp ',
                      ).format(widget.price),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: blueColor,
                      ),
                    ),
                  ],
                ),
                widget.subtitle,
              ],
            ).constrained(width: size.width - width - 48, height: 86),
          ],
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
