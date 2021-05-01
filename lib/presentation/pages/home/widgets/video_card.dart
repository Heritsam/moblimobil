import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/theme.dart';

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

    return Styled.widget(
      child: <Widget>[
        Container(
          height: size.height,
          width: size.width - 32,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.thumbnail,
              fit: BoxFit.cover,
            ),
          ),
        ),
        <Widget>[
          SizedBox().expanded(flex: 3),
          Styled.widget(
            child: Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 40,
            ).center(),
          )
              .decorated(
                shape: BoxShape.circle,
                color: Colors.black38,
              )
              .backgroundBlur(20)
              .clipRRect(all: 150)
              .constrained(height: 46, width: 46),
          SizedBox().expanded(),
          Styled.text(
            widget.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
              .padding(vertical: 8, left: 16, right: 10)
              .decorated(
                borderRadius: BorderRadius.circular(150),
                color: Colors.white54,
              )
              .backgroundBlur(20)
              .clipRRect(all: 150)
              .padding(horizontal: 8, vertical: 12)
              .constrained(width: size.width - 32),
        ].toColumn(),
      ].toStack(alignment: Alignment.center),
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
