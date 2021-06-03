import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moblimobil/presentation/pages/news/news_detail_page.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/themes/theme.dart';
import '../../../notifiers/app_settings/app_settings_notifier.dart';
import '../../../widgets/mobli_tile.dart';
import '../../../widgets/shimmer/shimmer_mobli_tile.dart';
import '../viewmodels/news_list_notifier.dart';

class NewsList extends ConsumerWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final appSettings = watch(appSettingsNotifier);
    final state = watch(newsListNotifier);

    if (state.isLoading) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return ShimmerMobliTile().padding(bottom: 16);
        },
      );
    }

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      shrinkWrap: true,
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];

        return MobliTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/news-detail',
              arguments: NewsDetailArgs(item.id),
            );
          },
          imageUrl: item.file,
          title: item.title,
          isVideo: item.typeFile == 'video',
          subtitle: Row(
            children: [
              Text(
                timeago.format(item.createdAt, locale: appSettings.language),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: mediumGreyColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ).expanded(),
              InkResponse(
                onTap: () {},
                child: Icon(Icons.bookmark_border_rounded),
              ),
            ],
          ),
        ).padding(bottom: 16);
      },
    );
  }
}
