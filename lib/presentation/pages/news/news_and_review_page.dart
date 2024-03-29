import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/search_bar.dart';
import 'sections/news_category_tab.dart';
import 'sections/news_list.dart';
import 'sections/news_trending.dart';
import 'viewmodels/news_category_notifier.dart';
import 'viewmodels/news_list_notifier.dart';
import 'viewmodels/news_trending_notifier.dart';

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
      body: RefreshIndicator(
        onRefresh: () async {
          Future.wait([
            context.read(newsCategoryNotifier).fetch(),
            context.read(newsTrendingNotifier).fetch(),
            context.read(newsListNotifier).fetch(),
          ]);
        },
        displacement: 32 + mediaQuery.padding.top,
        edgeOffset: 32 + mediaQuery.padding.top,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: mediaQuery.padding.top + 56 + 16,
            bottom: 32,
          ),
          child: Column(
            children: [
              SearchBar(
                onChanged: context.read(newsListNotifier).changeSearchText,
                onSearch: (_) {
                  context.read(newsListNotifier).fetch();
                },
                onTextCleared: context.read(newsListNotifier).resetAndSearch,
              ).padding(horizontal: 16),
              NewsCategoryTab(),
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
              NewsTrending(),
              SizedBox(height: 8),
              Image.asset(
                'assets/ads.png',
                width: mediaQuery.size.width,
                height: 100,
                fit: BoxFit.fitWidth,
              ).backgroundColor(Color(0xffAEE3E5)),
              SizedBox(height: 16),
              NewsList(),
              SizedBox(height: mediaQuery.padding.top + 16),
            ],
          ),
        ),
      ),
    );
  }
}
