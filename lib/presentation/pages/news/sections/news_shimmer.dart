import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';

class NewsShimmer extends StatelessWidget {
  const NewsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: mediaQuery.padding.top),
      child: Shimmer.fromColors(
        baseColor: lightGreyColor,
        highlightColor: Colors.white24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.width / 1.5,
              width: size.width,
              color: lightGreyColor,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 14,
                  width: size.width / 2,
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
                ),
                Icon(Icons.bookmark_border_rounded, color: mediumGreyColor),
              ],
            ).padding(horizontal: 16),
            SizedBox(height: 32),
            Container(
              height: 20,
              width: size.width / 1.5,
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
            ),
            SizedBox(height: 8),
            Container(
              height: 20,
              width: size.width / 2,
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
            ),
            SizedBox(height: 32),
            Container(
              height: 14,
              width: size.width,
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
            ),
            SizedBox(height: 8),
            Container(
              height: 14,
              width: size.width / 2,
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
            ),
            SizedBox(height: 8),
            Container(
              height: 14,
              width: size.width / 3,
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
            ),
            SizedBox(height: 8),
            Container(
              height: 14,
              width: size.width / 1.5,
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
            ),
            SizedBox(height: 8),
            Container(
              height: 14,
              width: size.width / 1.2,
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
            ),
          ],
        ),
      ),
    );
  }
}
