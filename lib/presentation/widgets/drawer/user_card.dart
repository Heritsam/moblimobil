import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';

class UserCard extends StatefulWidget {
  final ImageProvider avatar;
  final String name;
  final String phone;
  final Function()? onTap;

  const UserCard({
    Key? key,
    required this.avatar,
    required this.name,
    required this.phone,
    this.onTap,
  }) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
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
            Text(
              'Rohayat G. Ade',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              '0812 3456 7890',
              style: TextStyle(color: greenColor, fontSize: 12),
            ),
          ]
              .toColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
              )
              .expanded(),
          SizedBox(width: 4),
          Icon(Icons.arrow_right_rounded, size: 52, color: mediumGreyColor),
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
