import 'package:flutter/material.dart';

import '../../core/themes/theme.dart';

class CircleImage extends StatelessWidget {
  final double size;
  final ImageProvider image;

  const CircleImage({
    Key? key,
    required this.size,
    this.image = const AssetImage('assets/profile_picture.png'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: lightGreyColor,
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
