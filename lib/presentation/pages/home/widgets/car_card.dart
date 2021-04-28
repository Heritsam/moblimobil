import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/theme.dart';
import '../../../../generated/l10n.dart';

class CarCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool hasUsed;
  final Function()? onTap;

  const CarCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
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
    return Styled.widget(
      child: <Widget>[
        <Widget>[
          Container(
            height: 120,
            width: 210,
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
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            )
                .padding(horizontal: 16, vertical: 4)
                .backgroundColor(redColor)
                .clipRRect(
                  topRight: 150,
                  bottomRight: 150,
                )
                .padding(top: 16),
        ].toStack(),
        SizedBox(height: 8),
        Text(
          widget.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4),
        Text(
          widget.subtitle,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ).constrained(width: 194).padding(horizontal: 8),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.center),
    )
        .backgroundColor(lightGreyColor)
        .borderRadius(all: defaultBorderRadius)
        .ripple()
        .backgroundColor(lightGreyColor, animate: true)
        .clipRRect(all: defaultBorderRadius)
        .borderRadius(all: defaultBorderRadius, animate: true)
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onTap,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}
