import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';

class ShimmerMobliTile extends StatelessWidget {
  const ShimmerMobliTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Shimmer.fromColors(
      baseColor: lightGreyColor,
      highlightColor: Colors.white24,
      child: Row(
        children: [
          Container(
            height: 90,
            width: 140,
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(mediumBorderRadius),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 16,
                width: size.width,
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(mediumBorderRadius),
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 14,
                width: size.width / 4,
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(mediumBorderRadius),
                ),
              ),
            ],
          ).constrained(width: size.width - 140 - 48, height: 86),
        ],
      ),
    );
  }
}
