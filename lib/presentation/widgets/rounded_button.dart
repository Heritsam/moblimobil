import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/theme.dart';

class RoundedButton extends StatefulWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Function()? onPressed;

  const RoundedButton({
    Key? key,
    required this.label,
    this.backgroundColor = blueColor,
    this.textColor = Colors.white,
    this.onPressed,
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
        .padding(vertical: 16, horizontal: 59)
        .borderRadius(all: defaultBorderRadius)
        .ripple()
        .backgroundColor(widget.backgroundColor, animate: true)
        .clipRRect(all: defaultBorderRadius)
        .borderRadius(all: defaultBorderRadius, animate: true)
        .elevation(
          _isPressed ? 2 : 10,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          shadowColor: widget.backgroundColor.withOpacity(.38),
        )
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onPressed,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}
