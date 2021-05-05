import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';

class BrandItem extends StatefulWidget {
  final ImageProvider image;
  final Function()? onTap;

  const BrandItem({
    Key? key,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  _BrandItemState createState() => _BrandItemState();
}

class _BrandItemState extends State<BrandItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Styled.widget(child: Image(image: widget.image))
        .padding(all: 4)
        .borderRadius(all: defaultBorderRadius)
        .ripple()
        .backgroundColor(Colors.white, animate: true)
        .clipRRect(all: defaultBorderRadius)
        .borderRadius(all: defaultBorderRadius, animate: true)
        .elevation(
          _isPressed ? 2 : 10,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          shadowColor: Colors.black38,
        )
        .constrained(height: 73, width: size.width / 4 - 16)
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onTap,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}
