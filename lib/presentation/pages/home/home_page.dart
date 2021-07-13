import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../notifiers/bottom_nav/bottom_nav_notifier.dart';
import '../cars/modals/sort_and_filter.dart';
import '../notification/viewmodels/notification_viewmodel.dart';
import '../search/viewmodels/search_viewmodel.dart';
import 'sections/home_banner.dart';
import 'sections/home_choose_us.dart';
import 'sections/home_city.dart';
import 'sections/home_hot_deals.dart';
import 'sections/home_news_and_review.dart';
import 'sections/home_popular_cars.dart';
import 'sections/home_sort_by_brand.dart';
import 'sections/home_sort_by_price.dart';
import 'viewmodels/choose_us_notifier.dart';
import 'viewmodels/home_banner_notifier.dart';
import 'viewmodels/home_city_notifier.dart';
import 'viewmodels/home_news_and_review_notifier.dart';
import 'viewmodels/hot_deals_notifier.dart';
import 'viewmodels/popular_cars_notifier.dart';
import 'viewmodels/sort_by_brand_notifier.dart';
import 'viewmodels/sort_by_price_notifier.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white70,
        centerTitle: false,
        elevation: 0,
        title: Image.asset('assets/belimobil.png', height: 28),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        actions: [
          Consumer(
            builder: (context, watch, child) {
              final notifier = watch(notificationViewModel);

              return IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/notification');
                },
                icon: Badge(
                  showBadge: notifier.totalNotification > 0,
                  badgeContent: Text(notifier.totalNotification.toString())
                      .textColor(Colors.white),
                  badgeColor: redColor,
                  child: Icon(Icons.notifications_none_rounded),
                ),
              );
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Future.wait([
            context.read(notificationViewModel).fetch(),
            context.read(homeBannerNotifier).fetch(),
            context.read(chooseUsNotifier).fetch(),
            context.read(hotDealsNotifier).fetch(),
            context.read(popularCarsNotifier).fetch(),
            context.read(sortByPriceNotifier).fetch(),
            context.read(homeCityNotifier).fetch(),
            context.read(sortByBrandNotifier).fetch(),
            context.read(homeNewsAndReviewNotifier).fetch(),
          ]);
        },
        displacement: 32 + mediaQuery.padding.top,
        edgeOffset: 32 + mediaQuery.padding.top,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 56 + mediaQuery.padding.top),
          physics: BouncingScrollPhysics(),
          child: <Widget>[
            HomeBanner(),
            HomeChooseUs().padding(horizontal: 16, top: 8),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).newest, style: textTheme.headline6),
                InkResponse(
                  onTap: () {
                    context.read(bottomNavNotifier).changeIndex(1);
                    context.read(searchViewModel).selectSorting('Latest');
                    context.read(searchViewModel).search();
                  },
                  child: Text(
                    S.of(context).search,
                    style: TextStyle(color: blueColor),
                  ),
                ),
              ],
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            HomeHotDeals(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).popularCars, style: textTheme.headline6),
                InkResponse(
                  onTap: () {
                    context.read(bottomNavNotifier).changeIndex(1);
                    context.read(searchViewModel).selectSorting('Popular');
                    context.read(searchViewModel).search();
                  },
                  child: Text(
                    S.of(context).search,
                    style: TextStyle(color: blueColor),
                  ),
                ),
              ],
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            HomePopularCars(),
            Row(
              children: [
                Text(S.of(context).price, style: textTheme.headline6),
                InkResponse(
                  onTap: () {
                    context.read(bottomNavNotifier).changeIndex(1);
                    showDialog(
                      context: context,
                      builder: (context) => SortAndFilter(),
                    );
                  },
                  child: Text(
                    S.of(context).seeAll,
                    style: TextStyle(color: blueColor),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ).padding(horizontal: 16),
            SizedBox(height: 12),
            HomeSortByPrice(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).searchByLocation,
                  style: textTheme.headline6,
                ).expanded(),
                InkResponse(
                  onTap: () {
                    context.read(bottomNavNotifier).changeIndex(1);
                    showDialog(
                      context: context,
                      builder: (context) => SortAndFilter(),
                    );
                  },
                  child: Text(
                    S.of(context).seeAll,
                    style: TextStyle(color: blueColor),
                  ),
                ),
              ],
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            HomeCity(),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).searchByBrand, style: textTheme.headline6)
                    .expanded(),
                InkResponse(
                  onTap: () {
                    context.read(bottomNavNotifier).changeIndex(1);
                    showDialog(
                      context: context,
                      builder: (context) => SortAndFilter(),
                    );
                  },
                  child: Text(
                    S.of(context).seeAll,
                    style: TextStyle(color: blueColor),
                  ),
                ),
              ],
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            HomeSortByBrand(),
            SizedBox(height: 32),
            Row(
              children: [
                Text(S.of(context).newsAndReview, style: textTheme.headline6),
                InkResponse(
                  onTap: () {
                    context.read(bottomNavNotifier).changeIndex(2);
                  },
                  child: Text(
                    S.of(context).seeAll,
                    style: TextStyle(color: blueColor),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            HomeNewsAndReview(),
            SizedBox(height: 32 + mediaQuery.padding.bottom),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ),
      ),
    );
  }
}
