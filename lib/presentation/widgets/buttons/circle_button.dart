import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class CircleButton extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final Function()? onPressed;

  const CircleButton({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.onPressed,
  }) : super(key: key);

  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Styled.widget(child: widget.child)
        .padding(vertical: 12, horizontal: 12)
        .borderRadius(all: 150)
        .ripple()
        .backgroundColor(widget.backgroundColor, animate: true)
        .clipRRect(all: 150)
        .borderRadius(all: 150, animate: true)
        .elevation(
          _isPressed ? 2 : 10,
          borderRadius: BorderRadius.circular(150),
          shadowColor:Colors.black38,
        )
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onPressed,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}
