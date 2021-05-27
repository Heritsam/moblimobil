import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';

class RoundedIconButton extends StatefulWidget {
  final String? label;
  final Icon icon;
  final Color backgroundColor;
  final Color textColor;
  final double verticalPadding;
  final double horizontalPadding;
  final bool enabled;
  final bool elevated;
  final Function()? onPressed;

  const RoundedIconButton({
    Key? key,
    this.label,
    required this.icon,
    this.backgroundColor = blueColor,
    this.textColor = Colors.white,
    this.verticalPadding = 14,
    this.horizontalPadding = 32,
    this.enabled = true,
    this.elevated = true,
    this.onPressed,
  }) : super(key: key);

  @override
  _RoundedIconButtonState createState() => _RoundedIconButtonState();
}

class _RoundedIconButtonState extends State<RoundedIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon,
          if (widget.label != null) SizedBox(width: 8),
          if (widget.label != null)
            Text(
              widget.label ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: mediumGreyColor),
            ).flexible(),
        ],
      )
          .padding(
            vertical: widget.verticalPadding,
            horizontal: widget.horizontalPadding,
          )
          .borderRadius(all: defaultBorderRadius)
          .backgroundColor(lightGreyColor)
          .clipRRect(all: defaultBorderRadius);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.icon,
        if (widget.label != null) SizedBox(width: 8),
        if (widget.label != null)
          Text(
            widget.label ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: widget.textColor),
          ).flexible(),
      ],
    )
        .padding(
          vertical: widget.verticalPadding,
          horizontal: widget.horizontalPadding,
        )
        .borderRadius(all: defaultBorderRadius)
        .ripple()
        .backgroundColor(widget.backgroundColor, animate: true)
        .clipRRect(all: defaultBorderRadius)
        .borderRadius(all: defaultBorderRadius, animate: true)
        .elevation(
          widget.elevated
              ? _isPressed
                  ? 2
                  : 10
              : 0,
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
