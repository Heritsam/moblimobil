import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/news/news_card.dart';

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
          style: textTheme.headline6?.copyWith(color: darkGreyColor),
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
            <Widget>[
              Text(S.of(context).newsUpdates, style: textTheme.headline6),
              InkResponse(
                onTap: () {
                  Navigator.pushNamed(context, '/news-list');
                },
                child: Text(
                  S.of(context).seeAll,
                  style: TextStyle(color: greenColor),
                ),
              ),
            ]
                .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                .padding(horizontal: 16),
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
                  title: 'Lorem Ipsum',
                  description:
                      'Lorem Ipsum is simply dummy text of the printing Lorem Ipsum is simply dummy text.',
                  imageUrl: item.imageUrl,
                ).padding(right: 16, bottom: 32);
              },
            ).constrained(height: 256),
            <Widget>[
              Text(S.of(context).reviewUpdates, style: textTheme.headline6),
              InkResponse(
                onTap: () {
                  Navigator.pushNamed(context, '/reviews-list');
                },
                child: Text(
                  S.of(context).seeAll,
                  style: TextStyle(color: greenColor),
                ),
              ),
            ]
                .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                .padding(horizontal: 16),
            SizedBox(height: 16),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: carList.length,
              itemBuilder: (context, index) {
                final item = carList[index];

                return NewsCard(
                  onTap: () {
                    Navigator.pushNamed(context, '/news-detail');
                  },
                  title: 'Ipsum Lorem',
                  description:
                      'Lorem Ipsum is simply dummy text of the printing Lorem Ipsum is simply dummy text.',
                  imageUrl: item.imageUrl,
                ).padding(bottom: 16);
              },
            ),
          ],
        ),
      ),
    );
  }
}
