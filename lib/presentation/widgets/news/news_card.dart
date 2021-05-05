import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';

class NewsCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final Function()? onTap;

  const NewsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 32;

    return Styled.widget(
      child: <Widget>[
        Container(
          height: 135,
          width: width,
          decoration: BoxDecoration(
            color: lightGreyColor,
            image: DecorationImage(
              image: NetworkImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 12),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: darkGreyColor,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ).padding(horizontal: 16).constrained(width: width),
        SizedBox(height: 6),
        Text(
          widget.description,
          style: TextStyle(color: mediumGreyColor),
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ).padding(horizontal: 16).constrained(width: width),
        SizedBox(height: 16),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.center),
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
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onTap,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}
