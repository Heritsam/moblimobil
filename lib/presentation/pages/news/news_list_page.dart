import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/news/news_card.dart';

enum NewsListPageType { news, reviews }

class NewsListPage extends StatelessWidget {
  final NewsListPageType type;

  const NewsListPage({Key? key, required this.type}) : super(key: key);

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
          _title(context),
          style: textTheme.headline6?.copyWith(color: darkGreyColor),
        ),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 56 + 16,
          left: 16,
          right: 16,
          bottom: 32,
        ),
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
    );
  }

  String _title(BuildContext context) {
    if (type == NewsListPageType.news) return S.of(context).news;
    return S.of(context).reviews;
  }
}
