import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/themes/theme.dart';

class MobliTile extends StatefulWidget {
  final String title;
  final Widget subtitle;
  final String imageUrl;
  final bool isVideo;
  final Function()? onTap;
  final Function()? onLongPress;

  const MobliTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.isVideo = false,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  _MobliTile createState() => _MobliTile();
}

class _MobliTile extends State<MobliTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = 140.0;

    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
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
            if (widget.isVideo)
              Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 32,
              )
                  .center()
                  .decorated(
                    shape: BoxShape.circle,
                    color: Colors.black26,
                  )
                  .backgroundBlur(20)
                  .clipRRect(all: 150)
                  .constrained(height: 36, width: 36)
                  .alignment(Alignment.center),
          ],
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            widget.subtitle,
          ],
        ).constrained(width: size.width - width - 48, height: 86),
      ],
    )
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}
