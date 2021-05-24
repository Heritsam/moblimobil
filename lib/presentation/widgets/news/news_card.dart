import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../circle_image.dart';

class NewsCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final Function()? onTap;
  final double width;
  final double imageHeight;

  const NewsCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.onTap,
    this.width = 260,
    this.imageHeight = 160,
  }) : super(key: key);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final width = widget.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.imageHeight,
          width: width,
          decoration: BoxDecoration(
            color: lightGreyColor,
            image: DecorationImage(
              image: NetworkImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ).clipRRect(all: mediumBorderRadius),
        SizedBox(height: 12),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: darkGreyColor,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ).constrained(width: width),
        SizedBox(height: 12),
        Row(
          children: [
            CircleImage(
              size: 30,
              image: NetworkImage(
                'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Iustiar | 2 Jam Lalu',
              style: TextStyle(
                color: mediumGreyColor,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ).expanded(),
            InkResponse(
              onTap: () {},
              child: Icon(Icons.bookmark_border_rounded),
            ),
          ],
        ).constrained(width: width),
      ],
    )
        .borderRadius(all: defaultBorderRadius, animate: true)
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onTap,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}
