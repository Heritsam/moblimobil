import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/mobli_tile.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/video/video_trending_card.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        title: Text(
          S.of(context).videos,
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 72,
          bottom: mediaQuery.padding.bottom + 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar().padding(horizontal: 16),
            SizedBox(height: 24),
            Text(
              'Trending',
              style: textTheme.headline6?.copyWith(color: darkGreyColor),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: carList.length,
              itemBuilder: (context, index) {
                final item = carList[index];

                return VideoTrendingCard(
                  onTap: () {},
                  title:
                      'Lorem Ipsum is simply dummy text of the printing Lorem Ipsum is simply dummy text.',
                  imageUrl: item.imageUrl,
                ).padding(right: 16, bottom: 16);
              },
            ).constrained(height: 280),
            Text(
              'All Videos',
              style: textTheme.headline6?.copyWith(color: darkGreyColor),
            ).padding(horizontal: 16),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount: carList.length,
              itemBuilder: (context, index) {
                final item = carList[index];

                return MobliTile(
                  imageUrl: item.imageUrl,
                  title: 'Lorem Ipsum dolor sit amet amet amet amet wadawwww',
                  subtitle: Row(
                    children: [
                      Text(
                        '2 Jam yang lalu',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: mediumGreyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ).expanded(),
                    ],
                  ),
                ).padding(bottom: 16);
              },
            ),
          ],
        ),
      ),
    );
  }
}
