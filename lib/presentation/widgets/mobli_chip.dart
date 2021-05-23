import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/themes/theme.dart';

class MobliChip extends StatefulWidget {
  final String label;
  final bool selected;
  final Function()? onTap;
  final bool elevated;

  const MobliChip({
    Key? key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.elevated = true,
  }) : super(key: key);

  @override
  _MobliChipState createState() => _MobliChipState();
}

class _MobliChipState extends State<MobliChip> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: widget.selected ? Colors.white : darkGreyColor,
      ),
    )
        .padding(horizontal: 24, vertical: 12)
        .borderRadius(all: 150)
        .ripple()
        .backgroundColor(
          widget.selected ? blueColor : lightGreyColor,
          animate: true,
        )
        .clipRRect(all: 150)
        .borderRadius(all: 150, animate: true)
        .elevation(
          widget.elevated
              ? _isPressed
                  ? 2
                  : 10
              : 0,
          borderRadius: BorderRadius.circular(150),
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
