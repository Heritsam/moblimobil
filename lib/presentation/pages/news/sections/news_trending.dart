import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/themes/theme.dart';
import '../../../notifiers/app_settings/app_settings_notifier.dart';
import '../../../widgets/news/news_card.dart';
import '../news_detail_page.dart';
import '../viewmodels/news_trending_notifier.dart';

class NewsTrending extends ConsumerWidget {
  const NewsTrending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final appSettings = watch(appSettingsNotifier);
    final state = watch(newsTrendingNotifier);

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 160,
                  width: 260,
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(mediumBorderRadius),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  height: 16,
                  width: 220,
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(mediumBorderRadius),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  height: 14,
                  width: 120,
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(mediumBorderRadius),
                  ),
                ),
              ],
            ).padding(right: 16, bottom: 16),
          );
        },
      ).constrained(height: 280);
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];

        return NewsCard(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/news-detail',
              arguments: NewsDetailArgs(item.id),
            );
          },
          newsId: item.id,
          title: item.title,
          imageUrl: item.file,
          timestamp: timeago.format(
            item.createdAt,
            locale: appSettings.language,
          ),
          isVideo: item.typeFile == 'video',
        ).padding(right: 16, bottom: 16);
      },
    ).constrained(height: 280);
  }
}
