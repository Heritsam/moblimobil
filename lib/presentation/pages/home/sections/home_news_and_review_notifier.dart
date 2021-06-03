import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../../../widgets/video/video_card.dart';
import '../viewmodels/home_news_and_review_notifier.dart';

class HomeNewsAndReview extends ConsumerWidget {
  const HomeNewsAndReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(homeNewsAndReviewNotifier);

    if (state.isLoading) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: lightGreyColor,
            highlightColor: Colors.white24,
            child: Container(
              width: 320,
              height: 186,
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
            ),
          ).padding(right: 16, bottom: 24);
        },
      ).constrained(height: 210);
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];

        return VideoCard(
          thumbnail: NetworkImage(item.file),
          title: item.title,
          isVideo: item.typeFile == 'video',
        ).padding(right: 16, bottom: 24);
      },
    ).constrained(height: 210);
  }
}
