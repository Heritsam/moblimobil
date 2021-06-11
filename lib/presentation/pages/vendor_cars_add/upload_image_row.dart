import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import 'viewmodels/vendor_cars_add_viewmodel.dart';

class UploadImageRow extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final File? image;
  final Function()? onDelete;

  UploadImageRow({
    Key? key,
    this.image,
    this.onDelete,
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
                image: FileImage(image!),
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
              .gestures(onTap: onDelete),
        ],
      );
    }

    return GestureDetector(
      onTap: () async {
        final picked = await _picker.getImage(
          source: ImageSource.gallery,
          imageQuality: 50,
        );

        if (picked != null) {
          context.read(vendorCarsAddViewModel).addFile(File(picked.path));
          print(context.read(vendorCarsAddViewModel).files);
        } else {
          print('watdehel');
        }
      },
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
