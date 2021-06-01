import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../viewmodels/home_banner_notifier.dart';

class HomeBanner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = MediaQuery.of(context).size;
    final state = watch(homeBannerNotifier);

    if (state.isLoading) {
      return Shimmer.fromColors(
        baseColor: lightGreyColor,
        highlightColor: Colors.white24,
        child: Container(
          margin: EdgeInsets.all(16),
          height: 160,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            color: lightGreyColor,
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            initialPage: state.index,
            height: 160,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              context.read(homeBannerNotifier).indexChanged(index);
            },
          ),
          items: state.items.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  height: 160,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    image: DecorationImage(
                      image: NetworkImage(item.file),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        )
            .decorated(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            )
            .clipRRect(all: defaultBorderRadius)
            .elevation(
              10,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              shadowColor: Colors.black38,
            )
            .padding(all: 16)
            .animate(
              Duration(milliseconds: 175),
              Curves.fastLinearToSlowEaseIn,
            ),
        if (state.items.isNotEmpty)
          AnimatedSmoothIndicator(
            activeIndex: state.index,
            count: state.items.length,
            effect: WormEffect(
              activeDotColor: blueColor,
              dotColor: lightGreyColor.withOpacity(.24),
              dotHeight: 8,
              dotWidth: 8,
            ),
          ).padding(bottom: 28),
      ],
    );
  }
}
