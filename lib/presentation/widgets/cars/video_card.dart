import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';

class VideoCard extends StatefulWidget {
  final ImageProvider thumbnail;
  final String title;
  final Function()? onTap;

  const VideoCard({
    Key? key,
    required this.thumbnail,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = 320.0;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: size.height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: widget.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
        ).expanded(),
        Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: darkGreyColor,
          ),
        ).padding(all: 12).constrained(width: width),
      ],
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
    ;
  }
}
