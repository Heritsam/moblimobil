import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/mobli_tile.dart';
import '../../widgets/news/news_card.dart';
import '../../widgets/search_bar.dart';

class NewsAndReviewPage extends StatelessWidget {
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
          S.of(context).newsAndReview,
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 56 + 16,
          bottom: 32,
        ),
        child: Column(
          children: [
            SearchBar().padding(horizontal: 16),
            DefaultTabController(
              length: 5,
              child: TabBar(
                isScrollable: true,
                physics: BouncingScrollPhysics(),
                indicator: BoxDecoration(),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat',
                ),
                tabs: [
                  Tab(child: Text('Beranda')),
                  Tab(child: Text('Tips')),
                  Tab(child: Text('Test Drive')),
                  Tab(child: Text('Ulasan')),
                  Tab(child: Text('Mobil List')),
                ],
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Trending',
                  style: textTheme.headline6?.copyWith(color: darkGreyColor),
                ),
              ],
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: carList.length,
              itemBuilder: (context, index) {
                final item = carList[index];

                return NewsCard(
                  onTap: () {
                    Navigator.pushNamed(context, '/news-detail');
                  },
                  title:
                      'Lorem Ipsum is simply dummy text of the printing Lorem Ipsum is simply dummy text.',
                  imageUrl: item.imageUrl,
                ).padding(right: 16, bottom: 16);
              },
            ).constrained(height: 280),
            SizedBox(height: 8),
            Image.asset(
              'assets/ads.png',
              width: mediaQuery.size.width,
              height: 100,
              fit: BoxFit.fitWidth,
            ).backgroundColor(Color(0xffAEE3E5)),
            SizedBox(height: 16),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                final item = carList[index];

                return MobliTile(
                  imageUrl: item.imageUrl,
                  title: 'Lorem Ipsum dolor sit amet amet amet amet wadawwww',
                  subtitle: Row(
                    children: [
                      CircleImage(
                        image: NetworkImage(
                            'https://uifaces.co/our-content/donated/gPZwCbdS.jpg'),
                        size: 28,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Iustiar | 2 Jam yang lalu',
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
            ),
            SizedBox(height: mediaQuery.padding.top + 16),
          ],
        ),
      ),
    );
  }
}