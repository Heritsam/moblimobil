import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';

class ShimmerCarCard extends StatelessWidget {
  final double size;
  
  const ShimmerCarCard({Key? key, this.size = 160.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: lightGreyColor,
      highlightColor: Colors.white24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(mediumBorderRadius),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 16,
            width: size,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(mediumBorderRadius),
            ),
          ),
          SizedBox(height: 4),
          Container(
            height: 12,
            width: size,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(mediumBorderRadius),
            ),
          ),
        ],
      ).padding(right: 16, bottom: 32),
    );
  }
}
