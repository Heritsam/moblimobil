
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';

class UploadImageRow extends StatelessWidget {
  final ImageProvider? image;
  final Function()? onTap;

  UploadImageRow({
    Key? key,
    this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              image: DecorationImage(
                image: image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Icon(Icons.close, size: 18)
              .padding(all: 4)
              .backgroundColor(Colors.white54)
              .backgroundBlur(7)
              .clipOval()
              .padding(all: 8)
              .gestures(onTap: onTap),
        ],
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: Icon(
          Icons.add_circle_outline_rounded,
          size: 50,
          color: mediumGreyColor,
        ),
      ),
    );
  }
}
