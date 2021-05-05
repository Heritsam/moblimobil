import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';

class MenuItem extends StatefulWidget {
  final Widget icon;
  final String label;
  final Function()? onTap;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      Styled.widget(child: widget.icon)
          .padding(horizontal: 4, vertical: 12)
          .borderRadius(all: defaultBorderRadius)
          .ripple()
          .backgroundColor(Colors.white, animate: true)
          .clipRRect(all: defaultBorderRadius)
          .borderRadius(all: defaultBorderRadius, animate: true)
          .elevation(
            _isPressed ? 2 : 10,
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            shadowColor: Colors.black38,
          )
          .constrained(height: 73, width: 73)
          .gestures(
            onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
            onTap: widget.onTap,
          )
          .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
          .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn),
      SizedBox(height: 8),
      GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: darkGreyColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ].toColumn(mainAxisAlignment: MainAxisAlignment.center);
  }
}
