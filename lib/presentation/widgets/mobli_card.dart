import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/themes/theme.dart';

class MobliCard extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final EdgeInsets? padding;
  final Function()? onTap;

  const MobliCard({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  _MobliCardState createState() => _MobliCardState();
}

class _MobliCardState extends State<MobliCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(child: widget.child, padding: widget.padding)
        .borderRadius(all: defaultBorderRadius)
        .ripple()
        .backgroundColor(widget.backgroundColor)
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
