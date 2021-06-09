import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../notifiers/bottom_nav/bottom_nav_notifier.dart';
import '../../widgets/cars/location_chip.dart';
import 'sections/home_banner.dart';
import 'sections/home_choose_us.dart';
import 'sections/home_hot_deals.dart';
import 'sections/home_news_and_review.dart';
import 'sections/home_popular_cars.dart';
import 'sections/home_sort_by_brand.dart';
import 'sections/home_sort_by_price.dart';
import 'viewmodels/choose_us_notifier.dart';
import 'viewmodels/home_banner_notifier.dart';
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
    final size = mediaQuery.size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: false,
        elevation: 0,
        title: Image.asset('assets/belimobil.png', height: 28),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
            icon: Badge(
              badgeContent: Text('1').textColor(Colors.white),
              badgeColor: redColor,
              child: Icon(Icons.notifications_none_rounded),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Future.wait([
            context.read(homeBannerNotifier).fetch(),
            context.read(chooseUsNotifier).fetch(),
            context.read(hotDealsNotifier).fetch(),
            context.read(popularCarsNotifier).fetch(),
            context.read(sortByPriceNotifier).fetch(),
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
            <Widget>[
              Text(S.of(context).hotDeals, style: textTheme.headline6),
              InkResponse(
                onTap: () {},
                child: Text(
                  S.of(context).seeAll,
                  style: TextStyle(color: blueColor),
                ),
              ),
            ]
                .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                .padding(horizontal: 16),
            SizedBox(height: 16),
            HomeHotDeals(),
            <Widget>[
              Text(S.of(context).popularCars, style: textTheme.headline6),
              InkResponse(
                onTap: () {},
                child: Text(
                  S.of(context).seeAll,
                  style: TextStyle(color: blueColor),
                ),
              ),
            ]
                .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                .padding(horizontal: 16),
            SizedBox(height: 16),
            HomePopularCars(),
            <Widget>[
              Text(S.of(context).price, style: textTheme.headline6),
              InkResponse(
                onTap: () {},
                child: Text(
                  S.of(context).seeAll,
                  style: TextStyle(color: blueColor),
                ),
              ),
            ]
                .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                .padding(horizontal: 16),
            SizedBox(height: 12),
            HomeSortByPrice(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).searchByLocation,
                  style: textTheme.headline6,
                ),
              ],
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 14,
              children: [
                'Jakarta',
                'Tangerang',
                'Bogor',
                'Depok',
                'Bandung',
                'Detroit',
              ].map((e) {
                return LocationChip(
                  label: e,
                ).constrained(height: 44, width: size.width / 3 - 18);
              }).toList(),
            ).padding(horizontal: 16),
            SizedBox(height: 32),
            <Widget>[
              Text(S.of(context).searchByBrand, style: textTheme.headline6)
                  .expanded(),
              InkResponse(
                onTap: () {},
                child: Text(
                  S.of(context).seeAll,
                  style: TextStyle(color: blueColor),
                ),
              ),
            ]
                .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                .padding(horizontal: 16),
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
