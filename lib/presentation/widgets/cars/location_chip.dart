import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';

class LocationChip extends StatefulWidget {
  final String label;
  final Function()? onTap;

  const LocationChip({
    Key? key,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  _LocationChipState createState() => _LocationChipState();
}

class _LocationChipState extends State<LocationChip> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Styled.text(widget.label, style: TextStyle(color: Colors.white))
        .fittedBox()
        .padding(horizontal: 4, vertical: 14)
        .borderRadius(all: defaultBorderRadius)
        .ripple()
        .backgroundColor(blueColor, animate: true)
        .clipRRect(all: defaultBorderRadius)
        .borderRadius(all: defaultBorderRadius, animate: true)
        .elevation(
          _isPressed ? 2 : 10,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          shadowColor: greenColor.withOpacity(.38),
        )
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onTap,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}
