import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';

class PriceChip extends StatefulWidget {
  final String label;
  final bool selected;
  final Function()? onTap;

  const PriceChip({
    Key? key,
    required this.label,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  _PriceChipState createState() => _PriceChipState();
}

class _PriceChipState extends State<PriceChip> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Styled.text(
      widget.label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: widget.selected ? Colors.white : darkGreyColor,
      ),
    )
        .padding(horizontal: 24, vertical: 16)
        .borderRadius(all: defaultBorderRadius)
        .ripple()
        .backgroundColor(
          widget.selected ? blueColor : lightGreyColor,
          animate: true,
        )
        .clipRRect(all: defaultBorderRadius)
        .borderRadius(all: defaultBorderRadius, animate: true)
        .elevation(
          _isPressed ? 2 : 10,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          shadowColor:
              widget.selected ? blueColor.withOpacity(.38) : Colors.black38,
        )
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onTap,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}
