import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MobliLoadingIndicator extends StatefulWidget {
  @override
  _MobliLoadingIndicatorState createState() => _MobliLoadingIndicatorState();
}

class _MobliLoadingIndicatorState extends State<MobliLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = CurveTween(curve: Curves.easeInOut).animate(_controller)
      ..addListener(
        () => setState(() {}),
      );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Matrix4 transform = Matrix4.rotationZ(_animation.value * pi * 2.0);

    return Center(
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: SvgPicture.asset('assets/logo.svg', height: 64, width: 64),
      ),
    );
  }
}