import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/theme.dart';

class RoundedButton extends StatefulWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Function()? onTap;

  const RoundedButton({
    Key? key,
    required this.label,
    this.backgroundColor = blueColor,
    this.textColor = Colors.white,
    this.onTap,
  }) : super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.label,
      textAlign: TextAlign.center,
      style:
          Theme.of(context).textTheme.button?.copyWith(color: widget.textColor),
    )
        .padding(vertical: 16, horizontal: 64)
        .borderRadius(all: 150)
        .ripple()
        .backgroundColor(widget.backgroundColor, animate: true)
        .clipRRect(all: 150)
        .borderRadius(all: 150, animate: true)
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onTap,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}
