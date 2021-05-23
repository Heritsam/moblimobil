import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';

class DashboardItem extends StatefulWidget {
  final Widget icon;
  final String label;
  final Function()? onTap;
  final double size;

  const DashboardItem({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
    this.size = 73,
  }) : super(key: key);

  @override
  _DashboardItemState createState() => _DashboardItemState();
}

class _DashboardItemState extends State<DashboardItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      Styled.widget(child: widget.icon)
          .padding(all: 8)
          .borderRadius(all: mediumBorderRadius)
          .ripple()
          .backgroundColor(Colors.white, animate: true)
          .clipRRect(all: mediumBorderRadius)
          .borderRadius(all: mediumBorderRadius, animate: true)
          .elevation(
            _isPressed ? 2 : 10,
            borderRadius: BorderRadius.circular(mediumBorderRadius),
            shadowColor: Colors.black38,
          )
          .constrained(height: widget.size, width: widget.size)
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
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: mediumGreyColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ].toColumn(mainAxisAlignment: MainAxisAlignment.center);
  }
}