import 'package:flutter/material.dart';
import 'package:moblimobil/infrastructures/models/car.dart';
import 'package:styled_widget/styled_widget.dart';
import '../../../core/themes/theme.dart';

class UploadImageRow extends StatelessWidget {
  final bool image;

  const UploadImageRow({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image) {
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
                image: NetworkImage(carList[3].imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Icon(Icons.close, size: 18)
          .padding(all: 4)
              .backgroundColor(Colors.white54)
              .backgroundBlur(7)
              .clipOval()
              .padding(all: 8),
        ],
      );
    }

    return Container(
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
    );
  }
}
