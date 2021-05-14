import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';

class WhatsAppButton extends StatefulWidget {
  final String label;
  final bool enabled;
  final Function()? onPressed;

  const WhatsAppButton({
    Key? key,
    required this.label,
    this.enabled = true,
    this.onPressed,
  }) : super(key: key);

  @override
  _WhatsAppButtonState createState() => _WhatsAppButtonState();
}

class _WhatsAppButtonState extends State<WhatsAppButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/whatsapp_logo.png', height: 24, width: 24),
          SizedBox(width: 12),
          Text(
            widget.label,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ).flexible()
        ],
      )
          .padding(vertical: 12, horizontal: 16)
          .borderRadius(all: 150)
          .backgroundColor(lightGreyColor)
          .clipRRect(all: 150);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/whatsapp_logo.png', height: 24, width: 24),
        SizedBox(width: 12),
        Text(
          widget.label,
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ).flexible(),
      ],
    )
        .padding(vertical: 12, horizontal: 16)
        .borderRadius(all: 150)
        .ripple()
        .backgroundColor(greenColor, animate: true)
        .clipRRect(all: 150)
        .borderRadius(all: 150, animate: true)
        .elevation(
          _isPressed ? 2 : 10,
          borderRadius: BorderRadius.circular(150),
          shadowColor: greenColor.withOpacity(.38),
        )
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onPressed,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}
