import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/theme.dart';

class SellerCard extends StatefulWidget {
  final ImageProvider avatar;
  final String name;
  final String phone;
  final Function()? onTap;

  const SellerCard({
    Key? key,
    required this.avatar,
    required this.name,
    required this.phone,
    this.onTap,
  }) : super(key: key);

  @override
  _SellerCardState createState() => _SellerCardState();
}

class _SellerCardState extends State<SellerCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Styled.widget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Styled.widget()
              .decorated(
                image: DecorationImage(
                  image: widget.avatar,
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
                color: mediumGreyColor,
              )
              .elevation(
                8,
                borderRadius: BorderRadius.circular(150),
                shadowColor: Colors.black26,
              )
              .constrained(height: 57, width: 57),
          SizedBox(width: 8),
          <Widget>[
            Row(
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ).flexible(),
                SizedBox(width: 8),
                Icon(Icons.verified, color: yellowColor),
              ],
            ),
            SizedBox(height: 4),
            Text(
              widget.phone,
              style: TextStyle(color: greenColor, fontSize: 12),
            ),
          ]
              .toColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
              )
              .expanded(),
        ],
      ),
    )
        .padding(vertical: 12, horizontal: 8)
        .borderRadius(all: defaultBorderRadius)
        .ripple(
          splashColor: greenColor.withOpacity(.12),
          highlightColor: greenColor.withOpacity(.26),
        )
        .backgroundColor(blueColor.withOpacity(.12), animate: true)
        .clipRRect(all: defaultBorderRadius)
        .borderRadius(all: defaultBorderRadius, animate: true)
        .constrained(height: 73, width: 73)
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onTap,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}
