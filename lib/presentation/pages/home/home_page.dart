import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/cars/brand_item.dart';
import '../../widgets/cars/car_card.dart';
import '../../widgets/cars/location_chip.dart';
import '../../widgets/cars/price_chip.dart';
import '../../widgets/video/video_card.dart';
import 'sections/home_banner.dart';
import 'sections/home_choose_us.dart';
import 'sections/home_hot_deals.dart';
import 'viewmodels/choose_us_notifier.dart';
import 'viewmodels/home_banner_notifier.dart';
import 'viewmodels/hot_deals_notifier.dart';

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
        title: Text(
          'LakuMobil',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
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
            ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: carList.length,
              itemBuilder: (context, index) {
                final item = carList[index];

                return CarCard(
                  onTap: () {
                    Navigator.pushNamed(context, '/cars-detail');
                  },
                  carId: item.id,
                  title: item.title,
                  price: item.price,
                  hasUsed: index.isEven,
                  imageUrl: item.imageUrl,
                ).padding(right: 16, bottom: 32);
              },
            ).constrained(height: 240),
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
            ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return PriceChip(
                  label: '100 jt - 300 jt',
                  selected: index == 0,
                ).padding(right: 16, bottom: 16);
              },
            ).constrained(height: 64),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: carList.length,
              itemBuilder: (context, index) {
                final item = carList[index];

                return CarCard(
                  onTap: () {
                    Navigator.pushNamed(context, '/cars-detail');
                  },
                  carId: item.id,
                  title: item.title,
                  price: item.price,
                  hasUsed: index.isEven,
                  imageUrl: item.imageUrl,
                ).padding(right: 16, bottom: 32);
              },
            ).constrained(height: 240),
            <Widget>[
              Text(S.of(context).searchByLocation, style: textTheme.headline6),
            ]
                .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                .padding(horizontal: 16),
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
            Wrap(
              spacing: 10,
              runSpacing: 12,
              children: [
                'assets/brands/toyota.png',
                'assets/brands/bmw.png',
                'assets/brands/suzuki.png',
                'assets/brands/honda.png',
                'assets/brands/nissan.png',
                'assets/brands/daihatsu.png',
                'assets/brands/mitsubishi.png',
                'assets/brands/datsun.png',
              ].map((e) {
                return BrandItem(
                  onTap: () {},
                  image: AssetImage(e),
                );
              }).toList(),
            ).padding(horizontal: 16),
            SizedBox(height: 32),
            Row(
              children: [
                Text(S.of(context).newsAndReview, style: textTheme.headline6),
                InkResponse(
                  onTap: () {
                    Navigator.pushNamed(context, '/videos');
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
            ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: 6,
              itemBuilder: (context, index) {
                return VideoCard(
                  thumbnail: AssetImage('assets/thumbnail.jpg'),
                  title: 'BTS 100 JUTA CHALLENGE: CHALLENGE OFF-ROAD',
                ).padding(right: 16, bottom: 24);
              },
            ).constrained(height: 210),
            SizedBox(height: 32 + mediaQuery.padding.bottom),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ),
      ),
    );
  }
}
