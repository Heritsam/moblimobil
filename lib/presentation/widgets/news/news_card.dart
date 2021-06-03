import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';

class NewsCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String timestamp;
  final bool isVideo;
  final Function()? onTap;
  final double width;
  final double imageHeight;

  const NewsCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.timestamp,
    required this.isVideo,
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
        Stack(
          alignment: Alignment.center,
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
            if (widget.isVideo)
              Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 48,
              )
                  .center()
                  .decorated(
                    shape: BoxShape.circle,
                    color: Colors.black26,
                  )
                  .backgroundBlur(20)
                  .clipRRect(all: 150)
                  .constrained(height: 52, width: 52)
                  .alignment(Alignment.center),
          ],
        ),
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
            Text(
              widget.timestamp,
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
